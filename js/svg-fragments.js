function inlineSVGs()
{
	/*
	 * Replace all SVG images with inline SVG.
	 * Adapted from http://stackoverflow.com/questions/11978995/how-to-change-color-of-svg-image-using-css-jquery-svg-image-replacement.
	 */
	$('img.svg').each(
		function()
		{
			var img = $(this);
			var imgID = img.attr( 'id' );
			var imgClass = img.attr( 'class' );
			var imgURL = img.attr( 'src' );
			
			$.get( imgURL, function( data )
			{
				// Get the SVG tag, ignore the rest
				var svg = $(data).find( 'svg' );
				
				// Add replaced image's ID to the new SVG
				if ( typeof imgID !== 'undefined' )
				{
					svg = svg.attr( 'id', imgID );
				}
				// Add replaced image's classes to the new SVG
				if ( typeof imgClass !== 'undefined' )
				{
					svg = svg.attr( 'class', imgClass + ' replaced-svg' );
				}
				
				// Remove any invalid XML tags as per http://validator.w3.org
				svg = svg.removeAttr( 'xmlns:a' );
				
				// Copy across the originals style (for the positioning in particular).
				svg.attr( 'style', img.attr( 'style' ) );
				svg.attr( 'preserveAspectRatio', 'xMinYMin meet' );
				svg.attr( 'viewBox', '0 0 ' + svg.attr( 'width' ) + ' ' + svg.attr( 'height' ) );
				svg.attr( 'width', img.width() );
				svg.attr( 'height', img.height() );
				// For some reason, the SVG ends up offset by about 15 pixels upwards??
				
				// Replace image with new SVG
				img.replaceWith( svg );
			});
		}
	);
}
