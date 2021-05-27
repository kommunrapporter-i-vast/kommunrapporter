install.packages("tidyverse")
install.packages("ggthemes")
instal.packages("pxweb")



## Läs in kommunnamn (det är ur denna lista man sedan loopar igenom namnen)

kommun <- pxweb_query_list <- 
  list("Region"=c("1315","1380","1381","1382","1383","1384","1401","1402","1407","1415","1419","1421","1427","1430","1435","1438","1439","1440","1441","1442","1443","1444","1445","1446","1447","1452","1460","1461","1462","1463","1465","1466","1470","1471","1472","1473","1480","1481","1482","1484","1485","1486","1487","1488","1489","1490","1491"),
       "Kon"=c("1+2"),
       "UtbNiv"=c("000","F","3","EU"),
       "BakgrVar"=c("tot20-64"),
       "ContentsCode"=c("000001T8"),
       "Tid"=c("2000","2001","2002","2003","2004","2005","2006","2007","2008","2009","2010","2011","2012","2013","2014","2015","2016","2017","2018","2019"))

# Download data 
kommun <- 
  pxweb_get(url = "http://api.scb.se/OV0104/v1/doris/sv/ssd/AA/AA0003/AA0003B/IntGr1KomKonUtb",
            query = pxweb_query_list)

# Convert to data.frame 
kommun <- as.data.frame(kommun, column.name.type = "text", variable.value.type = "text")

## Script för att generera alla rapporterna. Observera att man behöver ställa in 1) var den grundläggande markdown-filen ligger, 2) var rapporterna ska hamna

for (i in unique(kommun$region)) {
  rmarkdown::render("/cloud/project/kommunrapport.Rmd", 
                    params = list(My_City = i),
                    output_file=paste0(i, ".html"),
                    output_dir = '/cloud/project/rapporter')
}


