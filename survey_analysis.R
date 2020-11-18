library(ggplot2)
library(data.table)
library(quanteda)

preprocess <- function(df, pattern){
  pattern_id <- paste0("id|group|",pattern)
  subs <- df[,grepl(pattern_id, names(df))]
  names(subs) <- gsub(pattern,"",names(subs))
  dt <- as.data.table(subs)
  m <- melt(dt, id.vars = c("id","cgroup"))
  m
}

res <- as.data.frame(fread("data/intro-survey.csv"))

words <- gsub(" vs. |,,", ",",paste(res$general,collapse = ","))
quanteda::textplot_wordcloud(dfm(words,remove = ","),
                             color = rev(viridis::viridis_pal()(6)),
                             min_count = 1)



lang <- preprocess(res, "l_")
gg_lang <- ggplot(data = lang)
gg_lang +
  geom_bar(aes(x = value, fill = variable)) +
  facet_wrap("variable", nrow = 2) +
  theme_minimal() +
  theme(panel.grid.major.x = element_blank(),
        panel.spacing = unit(4, "lines")) +
  scale_x_discrete(name ="Language",
                   limits=factor(1:5)) +
  scale_fill_viridis_d()



wf <- preprocess(res, "w_")
gg_lang <- ggplot(data = wf)
gg_lang +
  geom_bar(aes(x = value, fill = variable)) +
  facet_wrap("variable") +
  theme_minimal() +
  scale_x_discrete(1:5)


infra <- preprocess(res, "i_")
gg_lang <- ggplot(data = infra)
gg_lang +
  geom_bar(aes(x = value, fill = variable)) +
  facet_wrap("variable") +
  theme_minimal() +
  scale_x_discrete(1:5)


# Grouped analysis
lang_by <- lang[,  list(avg =  mean(value)), list(cgroup,variable) ]

gg_groups <- ggplot(data = lang_by, aes(x = variable, y = avg, fill = cgroup))
gg_groups +
  geom_bar(position = "stack", stat="identity") +
  facet_wrap("cgroup") +
  theme_minimal()












