#' @param x names to choose from
create_group <- function(x, group_size = 4){

  if(length(group_size) > 5) stop("Groups cannot be larger than 5.")
  m_g <- c("Club","Spade","Heart", "Diamond","Joker")[1:group_size]
  if(length(x) < group_size){
    names(x) <- m_g[1:length(x)]
    return(x)
  }
  out <- sample(x, group_size)
  names(out) <- m_g
  out
}

#' @param x character vector of student names.
#' @param group_size integer from 1 to 5.
shuffle_cards <- function(x, group_size = 4){
  e <- new.env()
  e$av <- x
  no_grps <- ceiling(length(x) / group_size)
  groups <- list()
  for (i in 1:no_grps){
    g <- create_group(e$av, group_size)
    groups[[i]] <- g
    e$av <- e$av[!e$av %in% g]
  }
  names(groups) <- c("Aces", "Kings", "Queens","Jacks",
                     "Tens","Nines","Eights","Sevens","Sixes",
                     "Fives","Fours","Threes","Twos","Ones")[1:no_grps]
  groups
}


nms <- paste("student", c(LETTERS,letters)[1:33], sep = " ")
shuffle_cards(nms, 5)


students <- c(
  "Bérubé Caterina",
  "Chandra Adelina",
  "Ho	Wan Ri",
  "Javanmard Hoda",
  "Koller Daniela",
  "Krizakova Viola",
  "Lenzner Andrea Elisabeth",
  "Lichtin Florian Maurus",
  "Mühlebach Nina",
  "Schneider Lena",
  "Seiler	Pascal Raphael",
  "Siegrist	Anne Stefanie",
  "Toetzke Malte Lorenz",
  "Wey Simon",
  "Zachmann	Lucca",
  "David"
)

shuffle_cards(students,4)
