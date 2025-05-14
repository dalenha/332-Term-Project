<?php /* student.php */
require_once 'db_config.php';
require_once 'functions.php';

$out = "";
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    if (isset($_POST['byCourse'])) {
        $cid = intval($_POST['course']);
        $sql = "
          SELECT s.section_no, s.classroom, s.days,
                 TIME_FORMAT(s.start_time,'%H:%i') AS start_t,
                 TIME_FORMAT(s.end_time  ,'%H:%i') AS end_t,
                 COUNT(e.enroll_id) AS enrolled, s.seats
          FROM Section s
          LEFT JOIN Enrollment e ON e.sec_id = s.sec_id
          WHERE s.course_id = $cid
          GROUP BY s.sec_id";
        $res = $conn->query($sql);
        if ($res === false) {
          die("SQL error (byCourse): " . $conn->error);
        }
        $out .= "<h3>Sections for Course $cid</h3>
                 <table border=1><tr>
                 <th>Sec#</th><th>Room</th><th>Days</th>
                 <th>Start</th><th>End</th>
                 <th>Enrolled / Seats</th></tr>";
        while ($row = $res->fetch_assoc()) {
            $out .= "<tr><td>".$row['section_no']."</td>
                     <td>".escape($row['classroom'])."</td>
                     <td>".escape($row['days'])."</td>
                     <td>".$row['start_t']."</td>
                     <td>".$row['end_t']."</td>
                     <td>".$row['enrolled']." / ".$row['seats']."</td></tr>";
        }
        $out .= "</table>";
    }
    if (isset($_POST['byStudent'])) {
        $cwid = $conn->real_escape_string($_POST['cwid']);
        $sql = "
          SELECT c.title, s.section_no, e.grade
          FROM Enrollment e
          JOIN Section s ON s.sec_id = e.sec_id
          JOIN Course  c ON c.course_id = s.course_id
          WHERE e.cwid = '$cwid'";
        $res = $conn->query($sql);
        if ($res === false) {
          die("SQL error (byStudent): " . $conn->error);
        }
        $out .= "<h3>Transcript for $cwid</h3>
                 <table border=1><tr><th>Course</th>
                 <th>Sec#</th><th>Grade</th></tr>";
        while ($row = $res->fetch_assoc()) {
            $out .= "<tr><td>".escape($row['title'])."</td>
                     <td>".$row['section_no']."</td>
                     <td>".escape($row['grade'])."</td></tr>";
        }
        $out .= "</table>";
    }
}
?>
<!DOCTYPE html>
<html><head><title>Student Queries</title></head>
<body>
<h2>Student Interface</h2>

<!-- Form 1 -->
<form method="post">
<fieldset><legend>Sections of a Course</legend>
Course:
<select name="course">
<?php
$res = $conn->query("SELECT course_id, title FROM Course");
if ($res === false) {
    die("SQL error (course list): " . $conn->error);
}
option_list($res,'course_id','title');
?>
</select>
<button name="byCourse">Show</button>
</fieldset>
</form>

<!-- Form 2 -->
<form method="post">
<fieldset><legend>Student Transcript</legend>
CWID: <input name="cwid" required maxlength="9">
<button name="byStudent">Show</button>
</fieldset>
</form>

<hr><?= $out ?>
<p><a href="index.php">Back to menu</a></p>
</body></html>
