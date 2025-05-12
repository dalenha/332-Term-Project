<?php /* professor.php */
require_once 'db_config.php';
require_once 'functions.php';

/* ---------- handle actions ---------- */
$out = "";
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    if (isset($_POST['byProf'])) {
        $ssn = $conn->real_escape_string($_POST['ssn']);
        $sql = "
          SELECT c.title, s.classroom, s.days,
                 TIME_FORMAT(s.start_time,'%H:%i') AS start_t,
                 TIME_FORMAT(s.end_time  ,'%H:%i') AS end_t
          FROM Section s
          JOIN Course  c ON c.course_id = s.course_id
          WHERE s.prof_ssn = '$ssn'";
        $res = $conn->query($sql);
        $out .= "<h3>Classes taught by $ssn</h3><table border=1><tr>
                 <th>Course</th><th>Room</th><th>Days</th>
                 <th>Start</th><th>End</th></tr>";
        while ($row = $res->fetch_assoc()) {
            $out .= "<tr><td>".escape($row['title'])."</td>
                     <td>".escape($row['classroom'])."</td>
                     <td>".escape($row['days'])."</td>
                     <td>".escape($row['start_t'])."</td>
                     <td>".escape($row['end_t'])."</td></tr>";
        }
        $out .= "</table>";
    }
    if (isset($_POST['bySect'])) {
        $cid  = intval($_POST['course']);
        $sec  = intval($_POST['secno']);
        $sql = "
          SELECT grade, COUNT(*) AS cnt
          FROM Enrollment e
          JOIN Section s ON s.sec_id = e.sec_id
          WHERE s.course_id = $cid AND s.section_no = $sec
          GROUP BY grade ORDER BY grade";
        $res = $conn->query($sql);
        $out .= "<h3>Grade counts for Course $cid – Section $sec</h3>";
        $out .= "<table border=1><tr><th>Grade</th><th>#</th></tr>";
        while ($row = $res->fetch_assoc()) {
            $out .= "<tr><td>".escape($row['grade'])."</td>
                     <td>".$row['cnt']."</td></tr>";
        }
        $out .= "</table>";
    }
}
?>
<!DOCTYPE html>
<html><head><title>Professor Queries</title></head>
<body>
<h2>Professor Interface</h2>

<!-- Form 1 -->
<form method="post">
<fieldset><legend>Classes by Professor</legend>
SSN: <input name="ssn" required maxlength="9">
<button name="byProf">Show</button>
</fieldset>
</form>

<!-- Form 2 -->
<form method="post">
<fieldset><legend>Grade Distribution</legend>
Course:
<select name="course">
<?php
$res = $conn->query("SELECT course_id, title FROM Course");
option_list($res,'course_id','title');
?>
</select>
Section # <input type="number" name="secno" min="1" required>
<button name="bySect">Show</button>
</fieldset>
</form>

<hr><?= $out ?>
<p><a href="index.php">Back to menu</a></p>
</body></html>
