#--------------------Keep This function at the end of the pipeline------It's long---------
#These functions create the all possible unique filter Strings based on which parameters you pass in.
#They are broken up into smaller cells for readability sake and the first function below makes all the necesary 
#calls to the proceeding functions. So run each cell once so that the makeAllFilters function from above has all the 
#necessary dependencies. Their are 6 in total, one to call the other five and the five tiers of filter permutations.


filterStrings <- data.frame(ID = c(1:15000),
                            FilterString = c(""))
generateAllFilters <-
  function(cancers = NA,
           cancer_subtypes = NA,
           sexes = NA,
           races = NA,
           ages = NA) {
    if (is.na(cancer)) {
      print("ERROR: Must input a vector of cancer types")
      return(NA)
    }
    results <- c()
    #We commented out this fist append call in our analysis because we wanted to only use filters with a cancer and subtype as the base filter
    #results <- append(results, generateTier1Filters(cancers))
    results <-
      append(results, generateTier2Filters(cancers, cancer_subtypes))
    
    results <-
      append(results,
             generateTier3Filters(cancers, cancer_subtypes, sexes, races, ages))
    
    results <-
      append(results,
             generateTier4Filters(cancers, cancer_subtypes, sexes, races, ages))
    
    results <-
      append(results,
             generateTier5Filters(cancers, cancer_subtypes, sexes, races, ages))
    print(length(results))
    return(results)
  }




#--------------------------------Tier 1---Least Specific, only sort by major cancer type----------------
generateTier1Filters <- function(cancers) {
  results <- as.character(sapply(cancers, singleFilterSet))
  return(results)
}



#--------------------------------Tier 2---Sort with 2 filters--------------------------------------------

generateTier2Filters <-
  function(cancers = NA,
           cancer_subtypes = NA,
           sexes = NA,
           races = NA,
           ages = NA) {
    results <- c()
    if (!is.na(cancer_subtypes)) {
      for (cancer in cancers) {
        for (i in  1:length(cancer_subtypes[[cancer]])) {
          cancer_subtype <- rownames(as.matrix(cancer_subtypes[[cancer]]))[i]
          results <-
            append(results,
                   singleFilterSet(cancer, cancer_subtype = cancer_subtype))
        }
      }
    }
    if (!is.na(sexes)) {
      for (cancer in cancers) {
        for (sex in sexes) {
          results <- append(results, singleFilterSet(cancer, sex = sex))
        }
      }
    }
    
    if (!is.na(races)) {
      for (cancer in cancers) {
        for (race in races) {
          results <- append(results, singleFilterSet(cancer, race = race))
        }
      }
    }
    if (!is.na(ages)) {
      for (cancer in cancers) {
        for (age in ages) {
          results <- append(results, singleFilterSet(cancer, age = age))
        }
      }
    }
    return(results)
  }


#----------------------------------Tier 3---Sort with 3 filters----------------------------------------

generateTier3Filters <-
  function(cancers,
           cancer_subtypes,
           sexes,
           races,
           ages) {
    results <- c()
    if (!is.na(cancer_subtypes) & (!is.na(sexes))) {
      for (cancer in cancers) {
        for (i in  1:length(cancer_subtypes[[cancer]])) {
          cancer_subtype <- rownames(as.matrix(cancer_subtypes[[cancer]]))[i]
          for (sex in sexes) {
            results <-
              append(
                results,
                singleFilterSet(cancer, cancer_subtype = cancer_subtype, sex = sex)
              )
          }
        }
      }
    }
    if (!is.na(cancer_subtypes) & (!is.na(races))) {
      for (cancer in cancers) {
        for (i in  1:length(cancer_subtypes[[cancer]])) {
          cancer_subtype <- rownames(as.matrix(cancer_subtypes[[cancer]]))[i]
          for (race in races) {
            results <-
              append(
                results,
                singleFilterSet(cancer, cancer_subtype = cancer_subtype, race = race)
              )
          }
        }
      }
    }
    if (!is.na(cancer_subtypes) & (!is.na(ages))) {
      for (cancer in cancers) {
        for (i in  1:length(cancer_subtypes[[cancer]])) {
          cancer_subtype <- rownames(as.matrix(cancer_subtypes[[cancer]]))[i]
          for (age in ages) {
            results <-
              append(
                results,
                singleFilterSet(cancer, cancer_subtype = cancer_subtype, age = age)
              )
          }
        }
      }
    }
    if (!is.na(sexes) & (!is.na(races))) {
      for (cancer in cancers) {
        for (sex in sexes) {
          for (race in races) {
            results <-
              append(results,
                     singleFilterSet(cancer, sex = sex, race = race))
          }
        }
      }
    }
    if (!is.na(sexes) & (!is.na(ages))) {
      for (cancer in cancers) {
        for (sex in sexes) {
          for (age in ages) {
            results <-
              append(results, singleFilterSet(cancer, sex = sex, age = age))
          }
        }
      }
    }
    if (!is.na(races) & (!is.na(ages))) {
      for (cancer in cancers) {
        for (race in races) {
          for (age in ages) {
            results <-
              append(results,
                     singleFilterSet(cancer, race = race, age = age))
          }
        }
      }
    }
    return(results)
  }



#-----------------------------------Tier 4---Sort with 4 filters-----------------------------------------

generateTier4Filters <-
  function(cancers,
           cancer_subtypes,
           sexes,
           races,
           ages) {
    results <- c()
    if (!is.na(cancer_subtypes) & (!is.na(sexes)) & (!is.na(races))) {
      for (cancer in cancers) {
        for (i in  1:length(cancer_subtypes[[cancer]])) {
          cancer_subtype <- rownames(as.matrix(cancer_subtypes[[cancer]]))[i]
          for (sex in sexes) {
            for (race in races) {
              results <-
                append(
                  results,
                  singleFilterSet(
                    cancer,
                    cancer_subtype = cancer_subtype,
                    sex = sex,
                    race = race
                  )
                )
            }
          }
        }
      }
    }
    if (!is.na(cancer_subtypes) & (!is.na(sexes)) & (!is.na(ages))) {
      for (cancer in cancers) {
        for (i in  1:length(cancer_subtypes[[cancer]])) {
          cancer_subtype <- rownames(as.matrix(cancer_subtypes[[cancer]]))[i]
          for (sex in sexes) {
            for (age in ages) {
              results <-
                append(
                  results,
                  singleFilterSet(
                    cancer,
                    cancer_subtype = cancer_subtype,
                    sex = sex,
                    age = age
                  )
                )
            }
          }
        }
      }
    }
    if (!is.na(cancer_subtypes) & (!is.na(races)) & (!is.na(ages))) {
      for (cancer in cancers) {
        for (i in  1:length(cancer_subtypes[[cancer]])) {
          cancer_subtype <- rownames(as.matrix(cancer_subtypes[[cancer]]))[i]
          for (race in races) {
            for (age in ages) {
              results <-
                append(
                  results,
                  singleFilterSet(
                    cancer,
                    cancer_subtype = cancer_subtype,
                    race = race,
                    age = age
                  )
                )
            }
          }
        }
      }
    }
    if (!is.na(races) & (!is.na(sexes)) & (!is.na(ages))) {
      for (cancer in cancers) {
        for (race in races) {
          for (sex in sexes) {
            for (age in ages) {
              results <-
                append(results,
                       singleFilterSet(
                         cancer,
                         sex = sex,
                         race = race,
                         age = age
                       ))
            }
          }
        }
      }
    }
    return(results)
  }


#-------------------------------------------Tier 5---Sort with all 5 filters----------------------------------
generateTier5Filters <-
  function(cancers,
           cancer_subtypes,
           sexes,
           races,
           ages) {
    results <- c()
    if (!is.na(cancer_subtypes) &
        (!is.na(sexes)) & (!is.na(races)) & (!is.na(ages))) {
      for (cancer in cancers) {
        for (i in  1:length(cancer_subtypes[[cancer]])) {
          cancer_subtype <- rownames(as.matrix(cancer_subtypes[[cancer]]))[i]
          for (sex in sexes) {
            for (race in races) {
              for (age in ages) {
                results <-
                  append(results,
                    singleFilterSet(
                      cancer,
                      cancer_subtype = cancer_subtype,
                      sex = sex,
                      race = race,
                      age = age
                    )
                  )
              }
            }
          }
        }
      }
    }
    return(results)
  }
