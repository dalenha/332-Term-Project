<?php /* functions.php */
function escape($s) { return htmlspecialchars($s, ENT_QUOTES); }

function option_list($rows, $value_col, $text_col) {
    foreach ($rows as $r) {
        $v = escape($r[$value_col]);
        $t = escape($r[$text_col]);
        echo "<option value='$v'>$t</option>";
    }
}
?>
