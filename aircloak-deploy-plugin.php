<?php
/*
Plugin Name: Aircloak deployment
Description: Provides a one-click ability to deploy our website
Version: 0.1.0
Author: Sebastian Probst Eide
Text Domain: aircloak-wordpress-deploy
*/
// Exit if accessed directly

if ( ! defined( 'ABSPATH' ) ) {
	exit;
}

add_action('admin_menu', 'ac_deploy_add_menu');

function ac_deploy_add_menu() {
  add_management_page(
    'Deploy stage website to production',
    'Deploy to prod',
    'manage_options', 
    'acdeploy', 
    'ac_deployment_page'
  );
}

function render_currently_deploying() {
?>
<META HTTP-EQUIV="REFRESH" CONTENT="1">
<p>
  <strong>Notice:</strong> the site is currently being deployed.
</p>
<p>
  This page automatically refreshes every second and will go back to the default button once deployed.
</p>
<?php
}

function is_deploying() {  
  return file_exists('/tmp/aircloak-website-currently-deploying');
}

// mt_tools_page() displays the page content for the Test Tools submenu
function ac_deployment_page() {
  //must check that the user has the required capability 
  if (!current_user_can('manage_options'))
  {
    wp_die( __('You do not have sufficient permissions to access this page.') );
  }
?>
<h1>Aircloak stage to production deployment</h1>
<?php  
  
  // variables for the field and option names 
  $hidden_field_name = 'ac_hidden_field';

  if ( is_deploying() ) {
    render_currently_deploying();
  } else {
    
    // See if the user submitted the "deploy" button command
    if( isset($_POST[ $hidden_field_name ]) && $_POST[ $hidden_field_name ] == 'Y' ) {
      exec("/usr/local/bin/aircloak-website-release.sh  >/tmp/ac-deploy-log.txt 2>/tmp/ac-deploy-log.txt &");
      render_currently_deploying();
    } else {
?>
<div class="wrap">
  <form name="deploy_form" method="post" action="">
    <input type="hidden" name="<?php echo $hidden_field_name; ?>" value="Y">

    <p class="submit">
      <input type="submit" name="Deploy website" class="button-primary" value="Deploy website to production" />
    </p>

  </form>
</div>
<?php
      if ( file_exists('/tmp/ac-deploy-log.txt') ) {
        echo "<h2>Previous deployment log</h2>";
        echo "<pre>";
        readfile('/tmp/ac-deploy-log.txt');
        echo "</pre>";
      }
    }    
  }  
}