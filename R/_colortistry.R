
colortistry <- function(y, n=y, colors = character(0), ...) {
  ## save and set par plot margins
  old_par <- par(no.readonly = TRUE)
  par(mar = c(0, 0, 0, 0))
  
  ## initialize empty plot
  plot(NULL, xlim = c(0, n), ylim = c(0, y), xaxt = "n", yaxt = "n", xlab = "", ylab = "", bty = "n", main = "")
  
  for (i in 1:y) {
    colors = colorify(n = n, colors=colors, seed = i, ...)
    rect(xleft = 0:(n - 1), ybottom = i, xright = 1:n, ytop = i+1, col = colors, border = NA)
  }
  
  ## reset plot margins to default
  par(old_par)
}


# colortistry(y = 100, n = 3, colors = c("red", "white", "blue"), lf = 1.1, lv = -.1 )


y = 100

lf_values <- seq(1.0, 0.98, length.out = y)  # Scale lf from 1.1 to 0.98
gv_values <- seq(1, 2, length.out = y)      # Scale gv from 1 to 3

# Combine both lf and gv in one Map call
test <- Map(function(i, lf, gv) colortistry(y = i, n = 3, lf = lf, gv = gv, colors = c("red", "white", "blue")), 
            i = 1:y, lf = lf_values, gv = gv_values)



# TODO think about using a colortistry function to adjust values by Mapping, or to have more freedom adjusting colorify calls within the loop
