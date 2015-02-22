<?php
$data = array();
if( isset($_POST['image-description'] ) && !empty( $_FILES['image-file'] )){
  $message = array();
  $description = $_POST['image-description'];

  $userName="johanna_sandis@hotmail.com"; //$_SESSION[''];

  $validFormats = array("jpg","jpeg", "png", "gif");
  $maxFileSize = 1024*1024;

  $path = "../images/uploaded/".$userName."/"; 

  if(!file_exists($path)){
    mkdir($path);
  }

  $name = $_FILES['image-file']['name'];
  if ($_FILES['image-file']['error'] == 0) {            
    if ($_FILES['image-file']['size'] > $maxFileSize) {
        $message[] = "$name is too large!.";
        continue;
    } elseif( ! in_array(pathinfo(strtolower($name), PATHINFO_EXTENSION), $validFormats) ){
      $message[] = "$name is not a valid format";
      continue;
    } else{
      $imageSrc = $path.$name;
      if(move_uploaded_file($_FILES["image-file"]["tmp_name"], $imageSrc)) {
        $thumbnailSrc = "../images/uploaded/".$userName."/thumbnail_".$name;
        /*$data['thumbnail_src'] = $thumbnailSrc;
        $data['src'] = $imageSrc;
        $data['description'] = $description;*/
        thumbnail($imageSrc, $thumbnailSrc, 200);
        $message[] = "File uploaded successfully!";
      }
    }
  } else if($_FILES['image-file']['error'] == 4) {
    $message[] = "No file chosen";
  }

  
  echo(implode("<br>",$message));
  //echo json_encode($data);
} else {
  $data[] = 'No Image Selected..';
}


function thumbnail($src, $dist, $disWidth = 100 ){

  $img = '';
  $extension = strtolower(strrchr($src, '.'));
  switch($extension)
  {
    case '.jpg':
    case '.jpeg':
      $img = @imagecreatefromjpeg($src);
      break;
    case '.gif':
      $img = @imagecreatefromgif($src);
      break;
    case '.png':
      $img = @imagecreatefrompng($src);
      break;
  }
  $width = imagesx($img);
  $height = imagesy($img);




  $disHeight = $disWidth * ($height / $width);

  $newImage = imagecreatetruecolor($disWidth, $disHeight);
  imagecopyresampled($newImage, $img, 0, 0, 0, 0, $disWidth, $disHeight, $width, $height);


  $imageQuality = 100;

  switch($extension)
  {
    case '.jpg':
    case '.jpeg':
      if (imagetypes() & IMG_JPG) {
        imagejpeg($newImage, $dist, $imageQuality);
      }
      break;

    case '.gif':
      if (imagetypes() & IMG_GIF) {
        imagegif($newImage, $dist);
      }
      break;

    case '.png':
      $scaleQuality = round(($imageQuality/100) * 9);
      $invertScaleQuality = 9 - $scaleQuality;

      if (imagetypes() & IMG_PNG) {
        imagepng($newImage, $dist, $invertScaleQuality);
      }
      break;
  }
  imagedestroy($newImage);
}
