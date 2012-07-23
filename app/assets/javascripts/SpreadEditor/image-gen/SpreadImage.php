<?php

require_once 'position.php';

/**
 * Utility class to manage the spread image creation process and provide some simple API for external scripts
 *
 * @author Ad_Astra
 */
class SpreadImage {

    /**
     * The whole image canvas
     * @var image 
     */
    private $canvas;
    /**
     * Canvas width
     * @var integer 
     */
    private $width;
    
    /**
     * Canvas height
     * @var integer
     */
    private $height;

    /**
     * Path to the default font
     * @var string
     */
    private $font = "./georgia.ttf";

    /**
     * Image constructor that defines the main canvas size and color
     * @param integer $width Image width
     * @param integer $height Image height
     * @param array $bgColor Array with 'red', 'green' and 'blue' keys with integer values
     */
    public function __construct( $width, $height, $bgColor = array( 'red' => 73, 'green' => 109, 'blue' => 73 ) ) {
	$this->canvas = imagecreatetruecolor( $width, $height );
	if ( !is_array( $bgColor ) or !isset( $bgColor['red'] ) or !isset( $bgColor['green'] ) or !isset( $bgColor['blue'] ) ) {
	    throw new InvalidArgumentException( 'Background color should be an array with "red", "green" and "blue" keys' );
	}
	$this->width = $width;
	$this->height = $height;
	$backgroundColor = imagecolorallocate( $this->canvas, $bgColor['red'], $bgColor['green'], $bgColor['blue'] );
	imagefilledrectangle( $this->canvas, 0, 0, $this->width, $this->height, $backgroundColor );
    }

    /**
     * Adds a position's graphic representation to the canvas 
     * @param integer $number Printable position number
     * @param array $placement Position rectangle placement, encoded into an array with 'top' and 'left' keys
     * @param array $size Position rectangle size, encoded into an array with 'red', 'green' and 'blue' keys
     * @param string $textPosition Position box layout, either 'horizontal' or 'vertical'
     * @param array $bgColor Background color, encoded into an array with 'red', 'green' and 'blue' keys
     * @param array $borderColor Border and text color, encoded into an array with 'red', 'green' and 'blue' keys
     */
    public function addPosition( $number, $placement, $size, $textPosition = 'vertical', $bgColor = array( 'red' => 238, 'green' => 238, 'blue' => 238 ), $borderColor = array( 'red' => 0, 'green' => 0, 'blue' => 0 ) ) {
	$position = new Position( $this->canvas, $number, $placement, $size, $textPosition, $bgColor, $borderColor );
	$position->draw();
	return $position;
    }

    /**
     * Outputs the result in PNG format and deletes the canvas
     */
    public function outputImage() {
	$copyrightTextColor = imagecolorallocate( $this->canvas, 219, 219, 219 );
	$copyrightText = 'Редактор раскладов: http://ad-astra.name/SpreadEditor/';
	$copyrightTextSize = '7';
	$textBox = imagettfbbox( $copyrightTextSize, 0, $this->font, $copyrightText );
	imagettftext( $this->canvas, $copyrightTextSize, 0, $this->width - $textBox[4] - 15, $this->height - $textBox[5] - 15, $copyrightTextColor, $this->font, $copyrightText );
	imagepng( $this->canvas );
	imagedestroy( $this->canvas );
    }

}
