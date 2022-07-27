# BIFX 552 Class Project Dockerfile
# https://github.com/bifx552-22/BIFXproject

# build image in this directory with `docker build -t bifxproject -f Dockerfile ..`
# run image with `docker run --user shiny --rm -p 3838:3838 -t bifxproject`

# start with shiny server and R
FROM rocker/shiny:4.2.1

# install dependencies
RUN R -e 'install.packages("devtools")'

# install R packages
COPY /BIFXproject /home/BIFXproject
RUN R -e 'setwd("/home/BIFXproject"); devtools::install()'

# install shiny app
RUN rm /srv/shiny-server/index.html
RUN echo shinyApp\(ui = BIFXproject::app_ui\(\), server = BIFXproject::app_server\) > /srv/shiny-server/app.R

# run app
CMD ["/usr/bin/shiny-server"]