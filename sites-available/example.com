server {
    listen 80;
    server_name example.com;

    ## Access and error logs.
    access_log  /var/log/nginx/example.com_access.log;
    error_log   /var/log/nginx/example.com_error.log;

    ## Filesystem root of the site.
    root /var/www/example.com/docroot;

    # Specify which upstream this site should use. Below, the phpfpm upstream
    # will be used, which is assumed to be PHP 5.3. If your Drupal site is an
    # older version and requires PHP 5.2, you can use the php52fpm upstream
    # instead.
    set $php_upstream phpfpm;
    # PHP 5.2
    #set $php_upstream php52fpm;

    include drupal;
}

server {
    ## Redirect www.example.com to example.com.
    listen 80;
    server_name www.example.com;
    return 301 $scheme://example.com$request_uri;
}
