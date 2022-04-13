place_holder <- function(){
    x<-rnorm(20)
    y<-rnorm(20,1,0.5)
   df<-data.frame(x,y)
   ggplot(df,aes(x,y))+geom_blank() + 
 
    # scale_x_continuous(breaks=seq(5,20,1), limits = c(-.01, 1.01), expand = expansion()) + 
     # scale_y_continuous(labels = NULL, breaks = NULL) + 
    labs(y = "Scores", x = 'Hour', 
         title = 'Generate Data to See Results!') 

  
}