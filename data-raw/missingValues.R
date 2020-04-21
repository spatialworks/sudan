yyy <- temp1 %>%
  str_split(pattern = " ",
            simplify = TRUE)

zzz <- NULL

for(i in 1:nrow(yyy)) {
  zzz <- rbind(zzz, yyy[i, ][yyy[i, ] != ""])
}

zzz <- zzz[ , c(1:4, 6:8)]

zzz <- data.frame(zzz, stringsAsFactors = FALSE)

for(i in 2:ncol(zzz)) {
  zzz[ , i] <- as.numeric(zzz[ , i])
}

zzz[1, 2:7] - rowSums(zzz[2:17, 2:7])

###########

## Extract tables
temp1 <- temp[[3]][2:18] %>%
  stringr::str_remove_all(pattern = ",")

yyy <- temp1 %>%
  str_split(pattern = " ",
            simplify = TRUE)

zzz <- NULL

for(i in 1:nrow(yyy)) {
  zzz <- rbind(zzz, yyy[i, ][yyy[i, ] != ""])
}

zzz <- zzz[ , c(1:4, 6:8)]

zzz <- data.frame(zzz, stringsAsFactors = FALSE)

for(i in 2:ncol(zzz)) {
  zzz[ , i] <- as.numeric(zzz[ , i])
}

zzz[17, 2:7] - rowSums(zzz[1:16, 2:7])
