## code to prepare `DATASET` dataset goes here
usethis::use_data("DATASET")

############################### Make bathymetry files ###############################
library(sf)

southernBathymetry <- function(file, id) {
  st_read(file) %>%
    mutate(area = st_area(.)) %>% st_drop_geometry() %>%
    dplyr::group_by(Depth_ft) %>%
    dplyr::summarise(area = sum(area)) %>%
    mutate(LakeID = id) %>%
    mutate(Depth_m = Depth_ft * 0.3048) %>%
    select(LakeID, Depth_ft, Depth_m, area)
}

me = southernBathymetry('ntl153_v3_0/mendota-contours-all.shp', 'ME')
mo = southernBathymetry('ntl153_v3_0/monona-contours-all.shp', 'MO')
wi = southernBathymetry('ntl153_v3_0/wingra-contours-all.shp', 'WI')

# Northern Lakes
b.df = st_read('ntl153_v3_0/nhld_bathymetry.shp') %>%
  mutate(area = st_area(.)) %>%
  st_drop_geometry() %>%
  group_by(LakeID, Depth_ft) %>%
  dplyr::summarise(area = sum(area)) %>%
  mutate(Depth_m = Depth_ft * 0.3048) %>%
  select(LakeID, Depth_ft, Depth_m, area) %>%
  bind_rows(me, mo, wi)

# ggplot(b.df) + geom_point(aes(x = as.numeric(area), y = Depth_ft, color = LakeID)) +
#   scale_y_reverse() + scale_colour_viridis_d()

write_csv(b.df, 'NTL_bathymetry.csv')

# Calculate percent area for every contour
lakes = unique(b.df$LakeID)
new.b = list()
for (i in 1:length(lakes)) {
  id = lakes[i]

  bg = b.df %>%
    filter(LakeID == id)

  # Interpolate to meter scale
  area.interp = approx(x = bg$Depth_m, y = bg$area, xout = 0:round(tail(bg$Depth_m,1)))

  new.b[[i]] = data.frame(LakeID = id, depth = area.interp$x, area = area.interp$y)
}
new.b = do.call(rbind, new.b)
# ggplot(new.b) + geom_point(aes(x = as.numeric(area), y = depth, color = LakeID)) +
#   scale_y_reverse() + scale_colour_viridis_d()
write_csv(new.b, 'NTL_bathymetry_1m.csv')

############################### Make data files ###############################
# Original bathymetry
NTLbathymetry <-
  read_csv('data-raw/NTL_bathymetry.csv')

use_data(NTLbathymetry)

# 1 m interpolated bathymetry
NTLbathymetry_1m <-
  read_csv('data-raw/NTL_bathymetry_1m.csv')

use_data(NTLbathymetry_1m)
