<?
class Z_CONFIG {
	public static $API_ENABLED = true;
	public static $READ_ONLY = false;  // new
	public static $SYNC_ENABLED = true;  // old
	public static $PROCESSORS_ENABLED = true;  // old
	public static $MAINTENANCE_MESSAGE = 'Server updates in progress. Please try again in a few minutes.';
	public static $BACKOFF = 0;

	public static $TESTING_SITE = false;
	public static $DEV_SITE = false;
	
	public static $DEBUG_LOG = true;
	
	public static $BASE_URI = 'http://localhost:8080/';
	public static $API_BASE_URI = 'http://localhost:8080/';
	public static $WWW_BASE_URI = 'http://localhost:8080/';
	public static $SYNC_DOMAIN = 'localhost';  // old
	
	public static $AUTH_SALT = 'dhAyudsHU176dsqhUY';
	public static $API_SUPER_USERNAME = 'admin';
	public static $API_SUPER_PASSWORD = 'admin';
	
	public static $AWS_REGION = 'us-east-1';
	public static $AWS_ACCESS_KEY = 'zotero'; // leave credentials empty to use IAM role
	public static $AWS_SECRET_KEY = 'zoterodocker';
	public static $S3_ENDPOINT = 'localhost:8082';  // old
	public static $S3_BUCKET = 'zotero';
	public static $S3_BUCKET_CACHE = '';
	public static $S3_BUCKET_FULLTEXT = 'zotero-fulltext';
	public static $S3_BUCKET_ERRORS = '';  //new
	public static $SNS_ALERT_TOPIC = '';  //new

	public static $REDIS_HOSTS = [
		'default' => [
			'host' => 'redis'
		],
		'request-limiter' => [
			'host' => 'redis'
		],
		'notifications' => [
			'host' => 'redis'
		],
		'fulltext-migration' => [
			'host' => 'redis',
			'cluster' => false
		]
	];

	public static $REDIS_PREFIX = '';
	
	public static $MEMCACHED_ENABLED = true;
	public static $MEMCACHED_SERVERS = array(
		'memcached:11211:1'
	);
	
	public static $TRANSLATION_SERVERS = array(
		"translation1.localdomain:1969"
	);
	
	public static $CITATION_SERVERS = array(
		"citeserver1.localdomain:8080", "citeserver2.localdomain:8080"
	);
	
	public static $SEARCH_HOSTS = ['elasticsearch'];
	
	public static $GLOBAL_ITEMS_URL = '';
	
	public static $ATTACHMENT_PROXY_URL = "https://files.example.com/";  // new
	public static $ATTACHMENT_PROXY_SECRET = "";  // new
	
	public static $ATTACHMENT_SERVER_HOSTS = array("files1.localdomain", "files2.localdomain"); // old
	public static $ATTACHMENT_SERVER_DYNAMIC_PORT = 80; // old
	public static $ATTACHMENT_SERVER_STATIC_PORT = 81; // old
	public static $ATTACHMENT_SERVER_URL = "https://files.example.net"; // old
	public static $ATTACHMENT_SERVER_DOCROOT = "/var/www/attachments/"; // old
	
	public static $STATSD_ENABLED = false;
	public static $STATSD_PREFIX = "";
	public static $STATSD_HOST = "monitor.localdomain";
	public static $STATSD_PORT = 8125;
	
	public static $LOG_TO_SCRIBE = false;
	public static $LOG_ADDRESS = '';
	public static $LOG_PORT = 1463;
	public static $LOG_TIMEZONE = 'US/Eastern';
	public static $LOG_TARGET_DEFAULT = 'errors';
	
	public static $HTMLCLEAN_SERVER_URL = 'http://tinymce-clean-server:16342';
		
	public static $PROCESSOR_PORT_DOWNLOAD = 3455;  // old
	public static $PROCESSOR_PORT_UPLOAD = 3456;  // old
	public static $PROCESSOR_PORT_ERROR = 3457;  // old
	
	public static $PROCESSOR_LOG_TARGET_DOWNLOAD = 'sync-processor-download';  // old
	public static $PROCESSOR_LOG_TARGET_UPLOAD = 'sync-processor-upload';  // old
	public static $PROCESSOR_LOG_TARGET_ERROR = 'sync-processor-error';  // old
	
	public static $SYNC_DOWNLOAD_SMALLEST_FIRST = false;  // old
	public static $SYNC_UPLOAD_SMALLEST_FIRST = false;  // old

	// Set some things manually for running via command line
	public static $CLI_PHP_PATH = '/usr/bin/php';
	
	// Alternative to S3_BUCKET_ERRORS
	public static $SYNC_ERROR_PATH = '/var/log/apache2/';  // old
	public static $ERROR_PATH = '/var/log/apache2/';  // new
	
	public static $CACHE_VERSION_ATOM_ENTRY = 1;
	public static $CACHE_VERSION_BIB = 1;
	public static $CACHE_VERSION_ITEM_DATA = 1;
	public static $CACHE_VERSION_RESPONSE_JSON_COLLECTION = 1;  // new
	public static $CACHE_VERSION_RESPONSE_JSON_ITEM = 1;  // new
}
?>
