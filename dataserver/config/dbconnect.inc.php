<?
function Zotero_DBConnectAuth($db) {
	$charset = '';
	if ($db == 'master') {
		$host = 'mysql';
		$port = 3306;
		// $replicas = [['host' => '']];  //new
		$db = 'zotero_master';
		$user = 'root';
		$pass = '';  // leave empty
		// $state = 'up'; // 'up', 'readonly', 'down'
	}
	else if ($db == 'shard') {
		$host = 'mysql';
		$port = 3306;
		$db = 'zotero_shard_1';
		$user = 'root';
		$pass = '';  // leave empty
	}
	else if ($db == 'id1') {
		$host = 'mysql';
		$port = 3306;
		$db = 'zotero_ids';
		$user = 'root';
		$pass = '';  // leave empty
	}
	else if ($db == 'id2') {
		$host = 'mysql';
		$port = 3306;
		$db = 'zotero_ids';
		$user = 'root';
		$pass = '';  // leave empty
	}
	else if ($db == 'www1') {
		$host = 'mysql';
		$port = 3306;
		$db = 'zotero_www';
		$user = 'root';
		$pass = '';  // leave empty
	}
	else if ($db == 'www2') {
		$host = 'mysql';
		$port = 3306;
		$db = 'zotero_www';
		$user = 'root';
		$pass = '';  // leave empty
	}
	else {
		throw new Exception("Invalid db '$db'");
	}
	return [
		'host' => $host,
		'replicas' => !empty($replicas) ? $replicas : [],
		'port' => $port,
		'db' => $db,
		'user' => $user,
		'pass' => $pass,
		'charset' => $charset,
		'state' => !empty($state) ? $state : 'up'
	];
}
?>
