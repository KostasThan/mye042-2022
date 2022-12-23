$(document).ready(function() {

    //get the outside container
    const photosWrapper = $(".wrapper");
    
    //initialize the interval here so mouse leave has a reference to it
    var interval;

    //for each photo appearing to the user
    photosWrapper.each(function(){

        //when mouse is inside the image
        $(this).mouseenter( function() {

            //initialize variables
            var hiddenImagesContainer = $(this).find("#hiddenImages");
            var currentImage = $(this).find("#slide");
            var currentTitle = $(this).find(".titleText");
            var nextImageIndex = 0;

            interval = setInterval(() => {
                var hiddenImages = hiddenImagesContainer.children();

                //update the current image index
                nextImageIndex = (nextImageIndex + 1) % hiddenImages.length;

                //show the new image/title
                currentTitle[0].innerHTML = hiddenImages[nextImageIndex].alt;
                currentImage[0].src = hiddenImages[nextImageIndex].src;
            }, 1000);

        });

        //when mouse leaves the image
        $(this).mouseleave( function() {
            
            //get the same variables as before
            var hiddenImagesContainer = $(this).find("#hiddenImages");
            var currentImage = $(this).find("#slide");
            var currentTitle = $(this).find(".titleText");
            var hiddenImages = hiddenImagesContainer.children();

            //revert the photo to the first one
            currentTitle[0].innerHTML = hiddenImages[0].alt;
            currentImage[0].src = hiddenImages[0].src;

            //stop the interval
            clearInterval(interval);
        });
    });
})