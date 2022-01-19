
# INSTALL PACKAGE

install.packages("brickr")

# LOAD LIBRARIES 

library(brickr)
library(dplyr)


# MOSAICS, LOAD ANY PHOTO OR IMAGE

myImage_R <- png::readPNG("img/R_logo.png")

myImage_R %>% 
  image_to_mosaic(
    # DEFAULT SIZE IS "48x48" BRICKS
    50, 
    brightness = 1, 
    contrast = 1, 
    # SETTING BRICKS TO USE
    use_bricks = c("4x6", "2x4", "1x2", "1x1") 
  ) %>% 
  build_mosaic()

ggplot2::ggsave("img/R_logo_bricks.png", device="png")


# 3D FROM MOSAIC, LOAD ANY PHOTO OR IMAGE

myImage_R_3D <- png::readPNG("img/R_logo.png")

myImage_R_3D %>% 
  image_to_mosaic() %>% 
  # CONVERT TO 3D BRICKS
  bricks_from_mosaic() %>% 
  build_bricks()


# GET INSTRUCTIONS AND PIECES TO BUILD MODEL, LOAD ANY PHOTO OR IMAGE

myImageInstructions_R <- png::readPNG("img/R_logo.png") %>% 
  image_to_mosaic() 

myImageInstructions_R %>% 
  build_mosaic()
# GENERATING INSTRUCTIONS
myImageInstructions_R %>% 
  build_instructions(9)
# GENERATING PIECES
myImageInstructions_R %>% 
  build_pieces()


# BUILD 3D BRICK FROM "bricks_from_table()" FUNCTION

data.frame(
  Level = "A",
  x1 = 33 
) -> myBrick

myBrick %>% 
  # CONVERT INTO A BRICKR OBJECT
  bricks_from_table() %>% 
  build_bricks()


# BUILD HOUSE 3D BRICKS FROM "bricks_from_table()" FUNCTION

tibble::tribble(
  ~Level, ~x1, ~x2, ~x3, ~x4, ~x5,
  "A",   13,   13,   13,   13,   13,
  "A",   3,   0,   0,   0,   3,
  "A",   3,   0,   0,   0,   3,
  "A",   3,   3,   0,   3,   3,
  #---
  "B",   13,   13,   13,   13,   13,
  "B",   3,   0,   0,   0,   3,
  "B",   3,   0,   0,   0,   3,
  "B",   13,   13,   13,   13,   13,
  #---
  "C",   18,   18,   18,   18,   18,
  "C",   13,   13,   13,   13,   13,
  "C",   13,   13,   13,   13,   13,
  "C",   18,   18,   18,   18,   18,
  #---
  "D",   0,   0,   0,   0,   0,
  "D",   18,   18,   18,   18,   18,
  "D",   18,   18,   18,   18,   18,
  "D",   0,   0,   0,   0,   0
) -> myHouse

myHouse %>% 
  bricks_from_table() %>% 
  build_bricks()


# BUILD 3D BRICK FROM "bricks_from_coords()" FUNCTION

tibble::tibble(
  x = 1, y = 1, z = 1, color = "Bright orange"
) %>% 
  bricks_from_coords() %>% 
  build_bricks()


# BUILD 3D DONALD FROM "bricks_from_coords()" FUNCTION

# X AND Y NOT INCLUDED SINCE THEY ARE CONSTANT
# "b" IS BRICK & "p" IS PLATE (1-unit)
# "mid_level" HAS 3 UNITS: 0, 1, 2

tibble::tribble(
  ~z, ~mid_level,  ~piece_type, ~color,
  # ORANGE FEET
  1, 0, "b", "Bright orange", 
  # WHITE LEGS
  2, 0, "b", "White", 
  # BLUE SHIRT
  3, 0, "b", "Bright blue", 
  # ADD 2 PLATES HEIGHT
  4, 0, "p", "Bright blue", 
  4, 1, "p", "Bright blue",
  # BEAK
  4, 2, "p", "Bright orange", 
  # HEAD
  5, 0, "b", "White",
  6, 0, "p", "White",
  #CAP BRIM
  6, 1, "p", "Black", 
  # CAP
  6, 2, "p", "Bright blue" 
) -> donaldBricks

# "tidyr::expand()" ADD X AND Y, WHILE DUPLICATING EACH

donaldBricks %>% 
  tidyr::expand(x=1:2, y=1:2,tidyr::nesting(z, mid_level, piece_type, color)
  ) -> myDonald

myDonald %>% 
  bricks_from_coords() %>% 
  build_bricks(
    background_color = "#d8fdff" 
  )

