#' Luria-Delbruck simulator
#' 
#' @param generations   integer: how many generations of bacteria (30)
#' @param mu            numeric: the mutation rate (2.0e-8)
#'
#' @return              a data.frame: cols 'generation','n_sus','n_res','n_mut'
#'
#' @details Adapted from Martin Johnsson's code, http://onunicornsandgenes.blog
#'          Assumptions:
#'            n_sus(t+1) = 2(n_sus(t) - n_mut(t))
#'            n_res(t+1) = 2(n_res(t) + n_mut(t))
#'          Then:
#'            n_mut(t) ~ Bin(n_sus(t), mu)
#'
#' @examples
#'   cultures <- replicate(1000, culture(30, 2e-8), simplify = FALSE)
#'   combined <- do.call(rbind, cultures)
#'   combined$culture <- rep(1:1000, each=30)
#'   library(ggplot2)
#'   ggplot(combined, aes(x=generation, y=n_res, group=culture, alpha=I(0.1))) +
#'     geom_line() + theme_bw()
#'
#'   resistant <- unlist(lapply(cultures, function(x) max(x$n_res)))
#'   acquired <- rbinom(n = 1000, size = 2^29, 2e-8)
#'   resistant_combined <- rbind(transform(data.frame(resistant = acquired), 
#'                                                    model = "acquired"),
#'                               transform(data.frame(resistant = resistant), 
#'                                                    model = "mutation"))
#'   ggplot(resistant_combined, aes(x = resistant)) +
#'     geom_histogram(bins = 10) + facet_wrap(~ model, scale = "free_x")
#' 
#' @export
#'
culture <- function(generations=30, mu=2e-8) {
  n_sus <- numeric(generations)
  n_res <- numeric(generations)
  n_mut <- numeric(generations)
  n_sus[1] <- 1
  for (i in 1:(generations - 1)) {
    n_mut[i] <- rbinom(n = 1, size = n_sus[i], prob = mu)
    n_sus[i + 1] <- 2 * (n_sus[i] - n_mut[i])
    n_res[i + 1] <- 2 * (n_res[i] + n_mut[i])
  }
  data.frame(generation = 1:generations,
             n_sus,
             n_res,
             n_mut)
}
