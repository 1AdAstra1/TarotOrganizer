<?php

/**
 * Plain card image with no effects applied
 *
 * @author Ad_Astra
 */
class Card {

    /**
     * Relative path to the image
     * @var string 
     */
    private $path;

    /**
     * Card image width
     * @var integer 
     */
    private $width;

    /**
     * Card image height
     * @var integer 
     */
    private $height;

    /**
     * Card image canvas
     * @var image
     */
    private $image;

    /**
     * The constructor that sets up the properties
     * @param string $path Relative path to the image
     * @param boolean $reverted Tells whether the card is upside-down
     */
    public function __construct( $path, $reverted = false ) {
	$this->path = '../' . $path;
	$degrees = 180;
	list($this->width, $this->height) = getimagesize( $this->path );
	$this->image = imagecreatefromjpeg( $this->path );
	if ( $reverted === true ) {
	    $this->image = imagerotate($this->image, $degrees, 0);
	}
    }

    /**
     * Getter for the height property
     * @return integer 
     */
    public function getHeight() {
	return $this->height;
    }

    /**
     * Getter for the image property, returns the actual card picture
     * @return image
     */
    public function getImage() {
	return $this->image;
    }

    /**
     * Getter for the width property
     * @return integer 
     */
    public function getWidth() {
	return $this->width;
    }

}
