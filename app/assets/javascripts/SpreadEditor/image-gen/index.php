<?php

/*
 * Generates a PNG image from the form data provided, with default colors
 */

//error_reporting(E_ERROR);

require_once 'SpreadImage.php';

$imageWidth = intval( $_POST['image_width'] );
$imageHeight = intval( $_POST['image_height'] );

try {
    $image = new SpreadImage( $imageWidth, $imageHeight );

    if ( isset( $_POST['positions'] ) ) {
	foreach ( $_POST['positions'] as $position ) {
	    $number = $position['number'] + 1;
	    $placement = array( 'top' => intval( $position['top'] ), 'left' => intval( $position['left'] ) );
	    $size = array( 'height' => intval( $position['height'] ), 'width' => intval( $position['width'] ) );
	    $textPosition = $position['text_position'];

	    $imagePosition = $image->addPosition( $number, $placement, $size, $textPosition );
	    if ( isset( $position['card_path'] ) and isset( $position['card_height'] ) ) {
		$cardPath = $position['card_path'];
		$cardHeight = intval( $position['card_height'] );
		$reverted = ($position['card_reverted'] === 'true') ? true: false;
		$imagePosition->setCard( $cardPath, $cardHeight, $reverted );
	    }
	}
    }
} catch ( Exception $e ) {
    die( $e->getMessage() );
}

header( 'Content-Type: image/png' );
header( 'Content-disposition: attachment; filename=tarot-spread.png' );
$image->outputImage();
