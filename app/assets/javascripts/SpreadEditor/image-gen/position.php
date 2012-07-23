<?php

require_once 'card.php';
/**
 * One position, with text and (optionally) some card image
 * 
 * @author Ad_Astra
 */
class Position {

    /**
     * The whole image canvas
     * @var image 
     */
    private $canvas;
    
    /**
     * Printable position number
     * @var integer 
     */
    private $number;
    
    /**
     * Y coordinate of the position rectangle
     * @var integer 
     */
    private $top;
    
    /**
     * X coordinate of the position rectangle
     * @var integer 
     */
    private $left;
    
    /**
     * Width of the position rectangle
     * @var integer 
     */
    private $width;
    
    /**
     * Height of the position rectangle
     * @var integer 
     */
    private $height;
    
    /**
     * Position box layout, either 'horizontal' or 'vertical'
     * @var string 
     */
    private $textPosition;
    
    /**
     * Background color, encoded into an array with 'red', 'green' and 'blue' keys
     * @var array
     */
    private $bgColor;
    
    /**
     * Border and text color, encoded into an array with 'red', 'green' and 'blue' keys
     * @var array
     */
    private $borderColor;
    
    /**
     * Optional concrete card
     * @var Card
     */
    private $card;
    
    /**
     * Default text size
     * @var string
     */
    private $textSize = '20';

    /**
     * Path to the default font
     * @var string
     */
    private $font = "./georgia.ttf";
    
    /**
     * GD2 textbox to calculate the proper layout
     * @var array
     */
    private $textBox;

    /**
     * The constructor, sets up the properties from the params
     * @param image $canvas The whole image canvas
     * @param integer $number Printable position number
     * @param array $placement Position rectangle placement, encoded into an array with 'top' and 'left' keys
     * @param array $size Position rectangle size, encoded into an array with 'red', 'green' and 'blue' keys
     * @param string $textPosition Position box layout, either 'horizontal' or 'vertical'
     * @param array $bgColor Background color, encoded into an array with 'red', 'green' and 'blue' keys
     * @param array $borderColor Border and text color, encoded into an array with 'red', 'green' and 'blue' keys
     */
    public function __construct( $canvas, $number, $placement, $size, $textPosition = 'vertical', $bgColor = array( 'red' => 238, 'green' => 238, 'blue' => 238 ), $borderColor = array( 'red' => 0, 'green' => 0, 'blue' => 0 ) ) {
	if ( !is_array( $bgColor ) or !isset( $bgColor['red'] ) or !isset( $bgColor['green'] ) or !isset( $bgColor['blue'] ) ) {
	    throw new InvalidArgumentException( 'Position background color should be an array with "red", "green" and "blue" keys' );
	}
	if ( !is_array( $borderColor ) or !isset( $borderColor['red'] ) or !isset( $borderColor['green'] ) or !isset( $borderColor['blue'] ) ) {
	    throw new InvalidArgumentException( 'Position border color should be an array with "red", "green" and "blue" keys' );
	}
	if ( !is_array( $placement ) or !isset( $placement['top'] ) or !isset( $placement['left'] ) ) {
	    throw new InvalidArgumentException( 'Position placement should be an array with "top" and "left" keys' );
	}
	if ( !is_array( $size ) or !isset( $size['width'] ) or !isset( $size['height'] ) ) {
	    throw new InvalidArgumentException( 'Position size should be an array with "width" and "height" keys' );
	}

	$this->canvas = $canvas;
	$this->number = $number;
	$this->top = $placement['top'];
	$this->left = $placement['left'];
	$this->width = $size['width'] + 2;
	$this->height = $size['height'] + 2;
	$this->bgColor = $bgColor;
	$this->borderColor = $borderColor;
	$this->textPosition = $textPosition;
	
	$this->textBox = imagettfbbox( $this->textSize, 0, $this->font, $this->number );
    }

    /**
     * Sets the card property and adds the card image to the position rectangle
     * @param string $cardPath Relative path to the card image
     * @param integer $cardHeight Height of the card image
     * @param boolean $reverted Tells whether the card is upside-down
     */
    public function setCard( $cardPath, $cardHeight, $reverted = false ) {
	$this->card = new Card( $cardPath, $reverted );
	$cardWidth = round( $this->card->getWidth() * ($cardHeight / $this->card->getHeight()) );
	if ( $this->textPosition === 'vertical' ) {
	    $cardTop = $this->top + 32;
	    $cardLeft = $this->left + ($this->width - $cardWidth) / 2 + 1;
	} else {
	    $cardTop = $this->top + 3;
	    $cardLeft = $this->left + ($this->width - $cardWidth) / 2 + $this->textBox[4] + 3;
	}
	
	imagecopyresampled( $this->canvas, $this->card->getImage(), $cardLeft, $cardTop, 0, 0, $cardWidth, $cardHeight, $this->card->getWidth(), $this->card->getHeight() );
    }

    /**
     * Outputs the actual rectangle to the image canvas
     */
    public function draw() {
	$topStart = $this->top;
	$leftStart = $this->left;
	$topEnd = $topStart + $this->height;
	$leftEnd = $leftStart + $this->width;
	$background = imagecolorallocate( $this->canvas, $this->bgColor['red'], $this->bgColor['green'], $this->bgColor['blue'] );
	$borderAndText = imagecolorallocate( $this->canvas, $this->borderColor['red'], $this->borderColor['green'], $this->borderColor['blue'] );
	//card's border
	imagerectangle( $this->canvas, $leftStart, $topStart, $leftEnd, $topEnd, $borderAndText );
	//card body
	imagefilledrectangle( $this->canvas, $leftStart + 1, $topStart + 1, $leftEnd - 1, $topEnd - 1, $background );

	if ( $this->textPosition === 'vertical' ) {
	    $textTopStart = $topStart + 25;
	    $textLeftStart = $leftStart + $this->width / 2 - $this->textBox[4] / 2;
	} else {
	    $textTopStart = $topStart + $this->height / 2 - $this->textBox[5] / 2 ;
	    $textLeftStart = $leftStart + 10;
	}

	//card number
	imagettftext( $this->canvas, $this->textSize, 0, $textLeftStart, $textTopStart, $borderAndText, $this->font, $this->number );
    }

}
