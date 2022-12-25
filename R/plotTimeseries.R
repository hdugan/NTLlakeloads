#' Plot interpolate heatmap of entire timeseries
#'
#'
#' @param df.interpolated dataframe of weekly interpolated data. Output of weeklyInterpolate()
#' @param var Variable of interest. Use availableVars() to see available variables.
#' @param saveFig If TRUE, saves a png to the working directory (default = FALSE)
#' @import ggplot2
#' @import dplyr
#' @import lubridate
#' @export
plotTimeseries <- function(df.interpolated, var, saveFig = FALSE) {

  binsize = signif(max(df.interpolated$var,na.rm = T)/20,1)

  pY = ggplot(df.interpolated, aes(x = date, y = depth, z = var)) +
    geom_contour_filled(aes(fill = after_stat(level)), alpha = 0.9, binwidth = binsize) +
    scale_fill_viridis_d(name = var) +
    guides(fill = guide_colorsteps(barheight = unit(6, "cm"))) +
    ylab('Depth (m)') +
    scale_y_reverse(expand = expansion(0)) +
    scale_x_date(expand = expansion(0)) +
    theme_bw(base_size = 10) +
    theme(axis.title.x = element_blank())

  print(pY)

  if (saveFig == TRUE){
    ggsave(paste0('gamHeatMap_',lakeAbr,'_',var,'.png'), width = 7, height = 4)
  }

  return(pY)
}


#' Plot interpolate heatmap of single year
#'
#' @param df.interpolated dataframe of weekly interpolated data. Output of weeklyInterpolate()
#' @param var Variable of interest. Use availableVars() to see available variables.
#' @param observations To plot observed data, provide a dataframe of observed data. Output of weeklyInterpolate().  
#' If NULL (default) no points plotted 
#' @param chooseYear year of interest
#' @param limits range for color scale
#' @param saveFig If TRUE, saves a png to the working directory (default = FALSE)
#' @import ggplot2
#' @export
plotTimeseries.year <- function(df.interpolated, observations = NULL, var, chooseYear, saveFig = FALSE) {

  binsize = signif(max(df.interpolated$var,na.rm = T)/20,1)


  if(is.null(observations)) {
    pY = ggplot(df.interpolated, aes(x = date, y = depth, z = var)) +
      geom_contour_filled(aes(fill = after_stat(level)), alpha = 0.9, binwidth = binsize) +
      scale_fill_viridis_d(name = var) +
      guides(fill = guide_colorsteps(barheight = unit(6, "cm"))) +
      ylab('Dpeth (m)') +
      # coord_cartesian(xlim = as.Date(c(paste0(chooseYear,'-01-01'), paste0(chooseYear,'-12-31')))) +
      scale_y_reverse(expand = expansion(0)) +
      scale_x_date(expand = expansion(0), 
                   limits = c(as.Date(paste0(chooseYear,'-01-01')), as.Date(paste0(chooseYear,'-12-31')))) +
      theme_bw(base_size = 10) +
      theme(axis.title.x = element_blank())
    
  } else {
    
  obsY = observations |> 
    filter(!is.na(meanVar)) |> 
    filter(year(sampledate) == chooseYear)
    
  pY = ggplot(df.interpolated, aes(x = date, y = depth, z = var)) +
    geom_contour_filled(aes(fill = stat(level)), alpha = 0.9, binwidth = binsize) +
    scale_fill_viridis_d(name = var) +
    guides(fill = guide_colorsteps(barheight = unit(6, "cm"))) +
    geom_point(data = obsY, aes(x = sampledate, y = depth), size = 0.5) +
    geom_text(data = obsY, aes(x = sampledate, y = depth, label= meanVar),
              hjust= -0.2, vjust=1.2, size = 3, color = 'white') +
    scale_color_viridis_c() +
    ylab('Depth (m)') +
    scale_y_reverse(expand = expansion(0)) +
    scale_x_date(expand = expansion(0), 
                 limits = c(as.Date(paste0(chooseYear,'-01-01')), as.Date(paste0(chooseYear,'-12-31')))) +
    theme_bw(base_size = 10) +
    theme(axis.title.x = element_blank())
  }

  print(pY)

  if (saveFig == TRUE) {
    ggsave(paste0('gamHeatMap_',lakeAbr,'_',var,'_',chooseYear,'.png'), width = 7, height = 4)
  }
  return(pY)

}
