<?
class Z_CONFIG {
	public static $API_ENABLED = true;
	public static $READ_ONLY = false;  // new
	public static $MAINTENANCE_MESSAGE = 'Server updates in progress. Please try again in a few minutes.';
	public static $BACKOFF = 0;

	public static $TESTING_SITE = false;
	public static $DEV_SITE = false;
	
	public static $DEBUG_LOG = true;
	
	public static $BASE_URI = ''; // leave empty
	public static $API_BASE_URI = ''; // leave empty
	public static $WWW_BASE_URI = ''; // leave empty

	public static $AUTH_SALT = '';  // leave empty
	public static $API_SUPER_USERNAME = '';  // leave empty
	public static $API_SUPER_PASSWORD = '';  // leave empty
	
	public static $AWS_REGION = ''; // leave empty
	public static $AWS_ACCESS_KEY = ''; // leave empty
	public static $AWS_SECRET_KEY = ''; // leave empty
	public static $S3_ENDPOINT = ''; // leave empty
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
		"citeserver1.localdomain:80", "citeserver2.localdomain:80"
	);
	
	public static $SEARCH_HOSTS = ['elasticsearch'];
	
	public static $GLOBAL_ITEMS_URL = '';
	
	public static $ATTACHMENT_PROXY_URL = "https://files.example.com/";  // new
	public static $ATTACHMENT_PROXY_SECRET = "";  // new

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

	// Set some things manually for running via command line
	public static $CLI_PHP_PATH = '/usr/bin/php';
	
	// Alternative to S3_BUCKET_ERRORS
	public static $ERROR_PATH = '/var/log/apache2/';  // new
	
	public static $CACHE_VERSION_ATOM_ENTRY = 1;
	public static $CACHE_VERSION_BIB = 1;
	public static $CACHE_VERSION_ITEM_DATA = 1;
	public static $CACHE_VERSION_RESPONSE_JSON_COLLECTION = 1;  // new
	public static $CACHE_VERSION_RESPONSE_JSON_ITEM = 1;  // new
}

?>
