A Distant Reading of the Day of Archaeology
====

Introduction
----
The [Day of Archaeology](http://en.wikipedia.org/wiki/Day_of_Archaeology) is an event where archaeologists write about their activities on a [group blog](http://www.dayofarchaeology.com/). The event started in 2011 and aims to 'provide a window into the daily lives of archaeologists from all over the world'. Currently there are over 1000 posts on the blog, rather a lot to read in one sitting. Rather than closely read each post, we can do a distant reading to get some insights into the corpus. Distant reading is a term advocated by [Franco Moretti](http://en.wikipedia.org/wiki/Franco_Moretti) to refer to efforts to understand texts through quantitative analysis and visualisation. 

A quantitative method that has recently become [popular](http://mith.umd.edu/topic-modeling-in-the-humanities-an-overview/) for distant reading is [topic modelling](https://en.wikipedia.org/wiki/Topic_model/). To get some insights into what all these archaeologists were writing about, I've generated a topic model to find the most important themes amongst the posts. By browsing the topics I can see what they key ideas are without having to read every word of every post. This approach is inspired by Matt Jockers' [analysis of the 2010 Day of Digital Humanities blog posts](http://www.matthewjockers.net/2010/03/19/whos-your-dh-blog-mate-match-making-the-day-of-dh-bloggers-with-topic-modeling/), and Shawn Graham, who did a similar [analysis of the 2011 Day of Archaeology blog posts](http://electricarchaeology.ca/2012/07/09/mining-a-day-of-archaeology/) and has also written an [accessible introduction to topic modelling](http://programminghistorian.org/lessons/topic-modeling-and-mallet). 

The questions I'm attempting to answer with this distant reading include: what is a typical day for an archaeologist? What are the different kinds of day that are represented in this collection? Do all archaeologists have generally similar days or not? As an archaeologist also I'm curious to see how my day compares with others!

Method
----
My method uses the [R](http://www.r-project.org/) programming language and a few external tools, most notably [MALLET](http://mallet.cs.umass.edu/). The method should be completely reproducible using the code in this repository (go ahead and try it! If you're coming to R for the first time, I recommend using R with [RStudio](http://www.rstudio.com/ide/download/)). Here's a quick summary of the process, do inspect the code for more details. 

First, I scraped the [dayofarchaeology.com](http://www.dayofarchaeology.com) site to get the links to the full text of each post (because the front and subsequent pages of the main site only give a snippet of text as a teaser). The [blog](http://www.dayofarchaeology.com) has a [Creative Commons Attribution-ShareAlike 3.0 License](http://creativecommons.org/licenses/by-sa/3.0/) which means we are free to copy, share and remix the blog contents, provided we give proper attribution (did I mention all of this is coming from [dayofarchaeology.com](http://www.dayofarchaeology.com)?) and make the results available with the same or similar licence (I use the [MIT licence](http://opensource.org/licenses/MIT) for this repository, which is similar). Second, I pulled the full text from each post, along with the name of the author and the date. Third, I cleaned the text to remove unusual characters and formatting. Fourth, I generated a topic model using the latent Dirchlet allocation algorithm implemented MALLET (it's much faster that the pure R methods). I arbitrarily set the number of topics at 30 and generated one model with all posts from 2012-2013. Fifth, I computed a similarity matrix for the authors of each post based on the mixture of topics in each author's post. Sixth, I computed a k-means cluster analysis to assign each author into a group, based on the topics detected in their post. Seventh, I visualised the groups of authors with a network graph. Each step of the method has a corresponding file of R code in this repository. 

Results
----

I've put all the scraped data in a [csv file here](https://raw.github.com/benmarwick/dayofarchaeology/master/data/dayofarchaeology.csv) (right-click -> save link as...) in case you want to browse or do other analyses. The csv file contains the full text of each post, the name of the author, the date of publication and the URL of the post. 

#### Summary of the corpus

In the 2012-2013 corpus there are a total of 352,558 words in 622 blog posts by 370 unique authors (as of 5pm EST 28 July 2013, a few more posts trickled in after this time, but this analysis is a weekend project, so it stops on a Sunday evening). The author count is probably an underestimate as some posts ([like this very long one](http://www.dayofarchaeology.com/life-in-a-day-the-silchester-town-life-project/)) are written by multiple people using a common affiliation as the author name. There were fewer posts in 2013 (n = 273) compared to 2012 (n = 348), but the average length of the posts is slightly higher in 2013 (mean = 591) compared to 2012 (mean = 549). Here's a plot of the distribution of words per post by year:
![wpp](figures/wpp.png)

#### Summary of the topic model

Here are 50 key words for the 30 topics generated by the LDA model:
```
>[1] "excavation field area stone features ground excavations tools soil excavated test discovered campus feature involved surface high late story rock bone level dating pit pits areas natural source survey structures photo forms excavate excavating flint larger located deposits open fragments trowel clear difficult geophysical floor image entire buried filled allowed"                                                                                           
 [2] "field archaeologists past school professional interested ferry understanding favorite knowledge washington skills public farm individuals topic director communication screen interests responsibility profession experiences single popular article artifacts engage professionals macedonia academic real participation archeology band digs semester shows scientific future diversity enjoyed vcu unit sit civil pseudoarchaeology washington� dig responsibilities"
 [3] "past cemetery landscape learn understand human questions interested modern interest ceramics lab early understanding water archaeologists places identify enjoy animal record techniques bones common simply methods personal southern types lost studying simple reason helps program ceramic lives lack collecting communities othe lived step properly inside kids property locations surveying question"                                                            
 [4] "digital access open archaeologists archive ads database online content reports director app text images center media free video system community linked library grey files visual literature metadata punk toronto scarf web order articles mobile videos create adding file mukurtu thousands cultural platform image publication dead filemaker databases edit asi created"                                                                                           
 [5] "shelf �"� laarc gallery objects �s� archive number �"� center lottery ��� �.� cooper �^� �.� suggested orange object completely metal registered piece dayofarch �s� environmental discover random store ��� border solid width tweet margin auto float margin-top text-align img cfcfcf margin-left �"�.� we� medieval excavated london message textile holds�"                                                                                                        
 [6] "rcahms copyright scotland survey chosen built aerial ordnance stone castle database crown favourite historic landscape north twitter photographs view scottish loch fort record park south east images west wall water buildings structures photograph place myarchaeology.� canmore recorded visit revealed remains monuments timber image people history island stones century cropmarks location"                                                                    
 [7] "cat circus making desk bag fort centre dig observatory urns click colchester house hat green cans uppsala unit system cremation contents high article mining ice common garden yellow editor utah cwa regular session magazine friend captains folkestone auckland hold renovation army avoid newsletter care drop warm military sardine taylor� baseball"                                                                                                              
 [8] "museum objects display finds exhibition object museums coins treasure metal history antiquities coin silver database hoard scheme material social british casts case cases interested items detecting stolen classical looting tile temporary create gold market pas museum� north hertfordshire gallery portable conservation finder looted hitchin preserved story cast stories pot vessel"                                                                           
 [9] "shropshire hoard war space community bristol royalist detectorists bitterley veterans military graffiti county indigenous civil shrewsbury march garrison northern south army territory communities ludlow contemporary earth parliamentarian wem paid country family worth spacecraft nter jawoyn club force aboriginal parliamentarians brampton similar system support significant messages men castle rights relic cavalry"                                         
[10] "students community school dig volunteers student children learning people archaeologists visitors experience past involved history open events undergraduate learn training education workshops skills typical schools questions town activity weeks learned outreach science friends planning educational silchester class tour workshop pottery college gave talks teaching participants placement aim tours teach contribute"                                        
[11] "historic planning environment county wright vitaemilia policy law council conservation ireland committee protection issues commercial dayofarch government means rescue potential dayofarch� knowledge development board impact resources client records carried developer officers interest process buildings july works practice natural early national remains monitoring organisations sector officer sweden significance standards money organisation"             
[12] "des une arch� sur est pour dans qui nous pr� ologie avec par mon journ� moyen fouille inrap gallery int� aux vous occupation cette diagnostic m�me aussi donn� ont fait muller-pelletier sols ologues ologique lors exceptionnelle ces si� vie ils carine scientifique sont vestiges tre couverte viarmes ch� large questions"                                                                                                                                         
[13] "people it� years world things lot interesting reading read blog write means don� posts book head fun point can� didn� list weeks fact ago career books share called degree ideas pieces position you� kind stuff context they� thinking huge moving issues fit historical sitting resources person phd happened play talk"                                                                                                                                              
[14] "house remains century years land houses area gardens bones family middle small brown occupied called ancient bottom industrial lake fields conditions sample garden base and� living council estate church child cut destruction remaining teeth town college salt thin britain sea point farm fine green trees shown deposit market reach chapel"                                                                                                                      
[15] "material collection finds collections age excavations records artefacts iron years early excavated record pottery small late boxes box range archives publication archive ago storage store documents drawings modern original individual colleague technology documentation created bronze assistant task extensive building published making researchers began remains hill photograph centre collected catalogue town"                                               
[16] "ancient museum cultural conference history social academic institute teaching writing australia dissertation living egypt city department society culture early museums focused western published funding web science european past human discipline mentioned egyptian southern sciences interested eastern tomb humanities trip associate fellowship oxford universities included relevant professor on-line places materials world"                                  
[17] "interesting norfolk mola centre talk programme colleague range wood visitor festival landscape dating assemblage building neolithic closely timbers lottery anglo-saxon species grave england services involved fund coastal cba hearth senior discussion review waterlogged flots bone identification reminded specialists scotland csi radiocarbon action thames manager artist crannog graves offer specialist biggest"                                              
[18] "glass century assemblage cave island leather early mosaic interesting we� fragments white ireland nails shoe beautiful preserved discovery vessel wild norse end mountains opening covered bowl vessels bay galway shoes visible quarters piece common colleague degrees share flood imagine ale lion segni sides harbour men drawing french economic dublin roads"                                                                                                     
[19] "building medieval digging buildings city small trench finds crew construction excavating walls early dig hot built wall dug road lots street hole top urban inside weeks water brick library close heat town pottery fill samples deep food dates record pot block dark basement complex cleaning trenches experienced materials nearby pipe"                                                                                                                           
[20] "war camp world monuments john� british battle institute italy rome statue memorial evans faraday spain photos knossos italian malta command cambridge half fig bomber papers figures gave monument raf shells doa involvement spanish boat shamanic latin neolithic materials activity idea campaign crete negatives monticello pow tests japanese palatine copenhagen ioa"                                                                                             
[21] "museum mound grave west creek curator complex facility group making stones corn garden native tour display interpretive manchester days incised volunteers program gift room library consists culture museum.� slide documentary gcmac trays view flint burial film educational moundsville delf norona shop educator beads displays square visitors wonderful papers check care"                                                                                       
[22] "age church medieval bronze idaho iron palace ireland village early churches burials end burial farm national exmoor identified london coffin sandpoint post-medieval cist cremation land parish viking stepney close houses population peat valley happy green skeleton surrounded swca holy horse symbolic mola live mound spread boundary wooden moorland peterborough appaloosa"                                                                                     
[23] "che arqueologia archaeology� oday projeto dei montescudaio sambaqui progetto archeologia uma con modo delle all� sono cubat� layer pi� medievale montecorvino gli archeologi attraverso mio elementi pisa baldassarri post video cad museu prof sul virtual dell� sia questo lavorare naturalmente essere disegno bassa material autocad base file vital joinville stico"                                                                                               
[24] "conservation models wessex pitt rivers lab model wiltshire south large salisbury figurines excavated wood service areas plaster scanning maritime damage space materials equipment operation condition wreck paint cleaned surface general shopping treatment remove conserving imaging diving skeleton cleaning protected corrosion aim underwater scale fragile nightingale gallery heavy camera wooden loose"                                                        
[25] "it� week we� office bit days morning writing started start things check process archaeologists spend that� recording lot full afternoon hours couple london pretty main short small end finished ready final finally call don� half idea leave computer emails friday yesterday lunch current there� tea lots running you� making finish"                                                                                                                               
[26] "phd human student bones �???atalh� samples deer pottery bone turkey thesis worcester cake cardiff residues animal room neolithic collaboration difficult animals hut faunal close worcestershire jaffa jebel writing suggested slag pots hive fallow bronze favourite supportive materials huge hike peak isotope analysing smith published phds fellow changing activity laboratory researcher"                                                                          
[27] "survey gis record database understand aerial recording records laser maps wales photography photographic systems total world techniques form spatial film cross trees multiple tables english discussion hill processing leader landscapes valley involved software station scanner avon tree yorkshire field system relevant norwegian and� fields medieval structure context generally computers entered"                                                             
[28] "los para por las con m�s arqueolog� como arque� day trabajo proyecto arqueol� desde este pero sobre expressly stated licensed creative commons attribution-sharealike unported license logos muy todo mallou hist� nos hoy patrimonio ser ver hora tiempo tengo dayofarch entre historia as� tambi� madrid video dos grupo vez soy logo"                                                                                                                               
[29] "artifacts historic state historical public national park cultural arkansas lab history survey resources program african graduate philadelphia preservation pennsylvania unit states society native united artifact archeological county materials portion camp center property crm exhibit foundation bridge education century outreach findings station laboratory equipment curation assistant teach document americans preserve south"                               
[30] "day work time project creative licensed commons stated license expressly attribution-sharealike unported working today year heritage archaeologist find local team job projects life post important public spent large group including report place number fieldwork exciting staff visit set july future members provide colleagues hard based present worked plan management reports"
```
It should be pretty obvious that these topics are generated by a probabilistic algorithm rather than carefully organised by a person. For example, medieval churches and Idaho in topic 22 and the cat circus in topic 7 are rather dissonant combinations. However, many of the topics seem quite distinctive and coherent, such as 4, 6, and 20. A few topics seem to make sense as mixtures or [chimera topics](http://journalofdigitalhumanities.org/2-1/words-alone-by-benjamin-m-schmidt/), suggesting that a slightly higher number of topics might be more appropriate. Topic 25 is like an eerily garbled telegraphic text message from an unfortunate archaeologist chained to a desk (and is similar to Graham's [topic 17](http://graeworks.net/topic-model/doa2012/Topics/Topic17.html) from 2012). Topics 28 and 30 are colophon topics dominated by the license that is attached to each post. With additional effort and time, such as analysing topic diagnostics and excluding more stopwords and non-noun parts of speech we may be able to refine the topic model. 

#### Basic validation of the model

We can validate the model to a basic degree by closely reading a tiny random sample of the corpus to see if the model's classifications seem accurate. For example, here we can see the mixture of topics in the posts by my friend and colleague [Jacq Matthews](http://www.dayofarchaeology.com/author/jacquelinematthews/):

![Jacq's topics](figures/topicprops.png)

That seems pretty good, Jacq's 2012 post was about field work and her duties as an officer of the Australian Archaeological Association, while her 2013 post is more about social sciences and global cultural heritage.

And here's a graph of an interesting post by Ryan Baker on [using small aerial drones for archaeological photography, survey and model-making](http://www.dayofarchaeology.com/aerial-survey-of-archaeological-excavations-using-quad-rotor-and-hex-rotor-aircraft-arch-aerial/):

![Ryan's topics](figures/topicprops2.png)

A good classification, with high proportions of topic 24 that includes models, camera, figurines and equipment and topic 27 with survey, GIS and photography.

And here we can see that [Sarah Bennett](http://www.dayofarchaeology.com/author/bennetts/), an archaeologist in Florida, made quite different posts in each year:

![Sarah's topics](figures/topicprops3.png)

Sarah's 2013 post is about volunteers cleaning up a historic cemetery, which is nicely captured by topic 3. Topic 29 reflects the public volunteer aspect of the post. Sarah's 2012 post is about the excavation of a shell midden, clearly indicated by a high proportions of topic 1 and 20. Topic 20 is interesting because it seems mostly to be about the archaeology of war. We see 'shell' and 'shells' in topic 20 between the algorithm hasn't been able to distinguish between shells you eat and other kinds of shells (bombs, wrecked buildings, etc.). 

While the topic model has a few comical and naive moments, my informal and brief validation indicates that it is clearly not complete nonsense and is credible as a representation of the corpus. Note that each time you replicate the generation of this model you get slightly different topics because of the probabilistic nature of topic modelling. 

#### Visualisation of similar topics

To get a sense of relationships amongst the topics we can visualize a hierarchical clustering of topics. Here we can see that the museum topics tend to form a group distinct from the others. Excavation and field archaeology form a high-level cluster as well as regional historical archaeology topics (on the far right). The majority of topics are quite similar to each other.

![cluster of topics](figures/topiccluster.png)

#### Comparison of topics in 2012 and 2013

We can get an impression of the shift in topics from 2012 to 2013 by comparing the average proportions of each topic across all documents for each year. The five topics that are the most different are 12, 28, 6, 18 and 23. Topics 12, 23 and 28 are non-English language topics, suggesting are greater international contribution in 2013. Topic 6 seems to reflect the large number of posts in 2013 by or about archaeologists working with the Royal Commission on the Ancient and Historical Monuments of Scotland.

![difference in topics](figures/topicdiffs.png)

#### Groups of similar authors

Now that we've established the credibility of the topic model, we can look at how authors group together according to the mixtures of topics in their posts. This is provided as a community service so people can discover who is writing about similar topics. 

Here are the groups of authors I get after a k-means analysis on topic proportions. I arbitrarily set the number of groups at 30 (you can run the code yourself and change the number to see what happens). With additional effort we could [algorithmically determine the optimum number of groups](http://stackoverflow.com/questions/15376075/cluster-analysis-in-r-determine-the-optimal-number-of-clusters/15376462#15376462). If there is a number after the name it's because that author has more than one post on the blog. Reassuringly, most of the time we see multiple posts by the same author in the same cluster. Although we saw above that it's not always the case that one author writes about the same general mix of topics in their posts. 
```
[[1]]
 [1] "sarah_may1"          "Claire Bradshaw"     "MOLA.1"             
 [4] "MOLA.6"              "David Gurney.3"      "MOLA.8"             
 [7] "bajrjobs.4"          "EHZooarchaeologists" "Susan Greaney.1"    
[10] "Karen Stewart"      

[[2]]
 [1] "Laracuente"                 "Declan Moore (Moore Group)"
 [3] "Emily Wright"               "Kelly Powell"              
 [5] "JamesAlbone"                "David Gurney"              
 [7] "Helen Wells"                "Ian Richardson"            
 [9] "Paul McCulloch"             "MOLA.5"                    
[11] "David Gurney.2"             "Dan Hull"                  
[13] "ChrisCumberpatch"           "Charles Mount"             
[15] "sylvia.warman"              "Laura Belton"              
[17] "Robin Standring"            "Michelle Touton"           
[19] "Emily Wright.1"             "Chris Constable.1"         
[21] "Giles Carey"                "Roman Baths Museum.1"      
[23] "Manda Forster"              "Magnus Reuterdahl.1"       

[[3]]
 [1] "Stephen Kay"         "Caroline Goodson"    "Alexandra Knox"     
 [4] "dberryman"           "Valentina"           "MOLA.7"             
 [7] "MOLA.9"              "michigan"            "Zsolt Magyar"       
[10] "Marcel Cornellissen" "dberryman.1"         "rrohe"              
[13] "talia_shay.1"        "MOLA.15"             "MOLA.20"            
[16] "MOLA.23"             "tuzusai2012"         "cornelius.1"        
[19] "tuzusai2012.1"      

[[4]]
[1] "cartvol.3" "MOLA.10"   "cartvol.7" "MOLA.14"   "cartvol.8"

[[5]]
 [1] "Alan Simkins"                                  
 [2] "RCAHMS.2"                                      
 [3] "gabe"                                          
 [4] "SUrachi.1"                                     
 [5] "PalatineEastPotteryProject.1"                  
 [6] "Francesco Ripanti"                             
 [7] "David Gurney.4"                                
 [8] "Amesemi"                                       
 [9] "Italian National Association of Archaeologists"
[10] "edlyne"                                        
[11] "AMTTA"                                         
[12] "ffion"                                         
[13] "The Gabii Project"                             
[14] "Stefano Costa.1"                               
[15] "William Hafford"                               
[16] "brennawalks"                                   
[17] "David Gill"                                    
[18] "lofttroll"                                     
[19] "Henriette Roued-Cunliffe.2"                    
[20] "Bob Muckle.2"                                  

[[6]]
 [1] "carmean"              "Rachael Sparks"       "Heather Sebire"      
 [4] "Amanda Brooks"        "Heather Cline"        "sdhaddow"            
 [7] "Manchester Museum"    "Steve Compston"       "Martin Lominy"       
[10] "mcarra"               "David E. Rotenizer.1" "Dena Sedar"          
[13] "Heather Cline.1"      "NGO Archaeologica.2"  "Andrew Kirkland"     
[16] "Amanda Brooks.1"     

[[7]]
 [1] "Susan Greaney"                      "Bolton Library and Museum Services"
 [3] "Sarah JaneHarknett.1"               "Shawn Graham.1"                    
 [5] "Laura Burnett"                      "William Hafford.1"                 
 [7] "Craig Barker"                       "Julie Cassidy"                     
 [9] "Laura Burnett.2"                    "Candace Richards"                  

[[8]]
[1] "cristiana"             "cristiana.1"           "Jaime Almansa S�nchez"
[4] "Khawla Goussous"       "cartvol.4"             "archscotland"         
[7] "Cara Jones"            "Lorna Richardson.4"    "archscotland.1"       

[[9]]
 [1] "Kevin Wooldridge"                 "David Standing"                  
 [3] "Jonathan Haller"                  "Kayt Armstrong"                  
 [5] "clydeandavon"                     "clydeandavon.1"                  
 [7] "RCAHMS.12"                        "Spencer Gavin Smith.1"           
 [9] "Chiz Harward (Urban Archaeology)" "Jenny Ryder"                     
[11] "RCAHMS.24"                        "Rosalind Buck"                   
[13] "Cathy Dagg"                       "MOLA.11"                         
[15] "Chris Green"                      "Aerial-Cam"                      
[17] "ArcheoWebby.1"                    "popefinn"                        
[19] "Paul"                             "Tom Goskar"                      
[21] "Serra Head.1"                     "Andrew Mayfield.1"               
[23] "Giles Carey.1"                    "Spencer Gavin Smith.2"           

[[10]]
 [1] "Lorna Richardson"   "ArcheoWebby"        "Sophie Hay"        
 [4] "saraperry"          "David Howell"       "Kayt Armstrong.1"  
 [7] "Susan Johnston"     "Don Henson"         "Francesca Tronchin"
[10] "Don Henson.2"       "MOLA.25"            "Kristina Killgrove"

[[11]]
 [1] "Brian Kerr"            "bajrjobs"              "MOLA"                 
 [4] "Dawn McLaren"          "Somayyeh Mottaghi"     "Lorna Richardson.1"   
 [7] "Dana Goodburn-Brown"   "James Morris"          "Dana Goodburn-Brown.2"
[10] "Mike Heyworth"         "Anne Crone"           

[[12]]
 [1] "sclements"               "Cath Poucher"            "cartvol.2"              
 [4] "Carole Bancroft-Turner"  "Megan Rowland"           "Jaime Almansa S�nchez.5"
 [7] "Guy Hunt.1"              "judgec"                  "Don Henson.1"           
[10] "judgec.1"                "Sarah MacLean"          

[[13]]
 [1] "Chris Constable"     "Guy Hunt"            "Spencer Gavin Smith"
 [4] "Helen Williams"      "Alice Kershaw"       "Rena MacGuire"      
 [7] "Rachel Ives.2"       "MOLA.18"             "Claire Woodhead.5"  
[10] "nikolah"             "Claire Woodhead.6"   "De Kogge"           

[[14]]
 [1] "RCAHMS"     "RCAHMS.1"   "RCAHMS.3"   "RCAHMS.4"   "RCAHMS.5"   "RCAHMS.6"  
 [7] "RCAHMS.7"   "RCAHMS.8"   "RCAHMS.9"   "RCAHMS.11"  "RCAHMS.13"  "RCAHMS.14" 
[13] "RCAHMS.15"  "RCAHMS.17"  "RCAHMS.18"  "RCAHMS.19"  "RCAHMS.20"  "RCAHMS.21" 
[19] "RCAHMS.22"  "RCAHMS.23"  "RCAHMS.25"  "RCAHMS.27"  "RCAHMS.28"  "RCAHMS.30" 
[25] "RCAHMS.31"  "RCAHMS.32"  "RCAHMS.33"  "Garry Law"  "James Cole" "RCAHMS.34" 
[31] "RCAHMS.36"  "RCAHMS.38"  "RCAHMS.39"  "RCAHMS.41"  "RCAHMS.43" 

[[15]]
[1] "archaeologicalresearchcollective" "Tamira"                          
[3] "cartvol.6"                       

[[16]]
[1] "Sandra LozanoRubio"   "Rmadgwick"            "Sandra LozanoRubio.1"
[4] "Tim Young"            "Scott Haddow"        

[[17]]
 [1] "Ralph Mills"           "cartvol"               "cartvol.1"            
 [4] "mmrathgaber"           "MOLA.3"                "brennawalks@gmail.com"
 [7] "MOLA.12"               "Lynn Evans"            "Matt Law.3"           
[10] "Dave Wilton"           "april.beisaw"          "IUSB PAFS"            
[13] "MOLA.17"               "Claire Woodhead.4"     "MOLA.22"              
[16] "RCAHMS.37"             "Sue Carter"            "Lynn Evans.1"         
[19] "Sue Carter.1"          "Colleen Morgan"       

[[18]]
 [1] "Molly Swords"              "MOLA.2"                   
 [3] "RCAHMS.16"                 "Laura Puolamaki"          
 [5] "Exmoorhistoricenvironment" "Molly Swords.1"           
 [7] "Mary Petrich-Guy"          "Dot Boughton"             
 [9] "Asa M Larsson"             "Rachel Ives"              

[[19]]
  [1] "Waveney ValleyCommunityArchaeologyGroup"                                               
  [2] "Glynis Irwin"                                                                          
  [3] "David E. Rotenizer"                                                                    
  [4] "rbakerarae"                                                                            
  [5] "Keneiloe Molopyane"                                                                    
  [6] "Beth Pruitt"                                                                           
  [7] "Grace Krause"                                                                          
  [8] "Gail Boyle"                                                                            
  [9] "Sarah Bennett"                                                                         
 [10] "Thiago Fossile"                                                                        
 [11] "Peter Reavill"                                                                         
 [12] "Scott Clark"                                                                           
 [13] "Lancaster Williams"                                                                    
 [14] "Jaime Almansa S�nchez.1"                                                               
 [15] "Jaime Almansa S�nchez.2"                                                               
 [16] "David Garcia Casas"                                                                    
 [17] "Christine Morris"                                                                      
 [18] ""                                                                                      
 [19] "Magnus Reuterdahl"                                                                     
 [20] "April Beisaw"                                                                          
 [21] "Tricia Jarratt"                                                                        
 [22] "Anthroprobably"                                                                        
 [23] "diacarco"                                                                              
 [24] "EAAPP"                                                                                 
 [25] "Pedro MoyaMaleno"                                                                      
 [26] "RCAHMS.10"                                                                             
 [27] "Jaime Almansa S�nchez.3"                                                               
 [28] "Briana Pobiner"                                                                        
 [29] "jbarnes9"                                                                              
 [30] "David Gurney.1"                                                                        
 [31] "Helen Keremedjiev"                                                                     
 [32] "Bernard K. Means"                                                                      
 [33] "Kelly Abbott"                                                                          
 [34] "Charlotte Douglas"                                                                     
 [35] "Manchester Museum.1"                                                                   
 [36] "Adam Corsini.2"                                                                        
 [37] "Kelly Abbott.1"                                                                        
 [38] "INRAP"                                                                                 
 [39] "INRAP.1"                                                                               
 [40] "drspacejunk"                                                                           
 [41] "angela middleton"                                                                      
 [42] "Sebastian Foxley"                                                                      
 [43] "Kelly Abbott.2"                                                                        
 [44] "Kelly Abbott.3"                                                                        
 [45] "Claire Woodhead.2"                                                                     
 [46] "INRAP.2"                                                                               
 [47] "Michelle Zupan"                                                                        
 [48] "magago"                                                                                
 [49] "RCAHMS.26"                                                                             
 [50] "Jaime Almansa S�nchez.4"                                                               
 [51] "RCAHMS.29"                                                                             
 [52] "Giuliano De Felice"                                                                    
 [53] "ArchaeoAD"                                                                             
 [54] "Becky Wragg Sykes"                                                                     
 [55] "Daniel Pett"                                                                           
 [56] "Lorna Richardson.2"                                                                    
 [57] "Lorna Richardson.3"                                                                    
 [58] "Lorna Richardson.5"                                                                    
 [59] "Lorna Richardson.6"                                                                    
 [60] "Lorna Richardson.7"                                                                    
 [61] "Lorna Richardson.8"                                                                    
 [62] "Todd Whitelaw"                                                                         
 [63] "Valentina.1"                                                                           
 [64] "Simone82"                                                                              
 [65] "Andrea"                                                                                
 [66] "Elizabeth Moore"                                                                       
 [67] "Anabelle Casta�o"                                                                      
 [68] "Wessex Archaeology"                                                                    
 [69] "Wessex Archaeology.1"                                                                  
 [70] "Wessex Archaeology.2"                                                                  
 [71] "Wessex Archaeology.3"                                                                  
 [72] "AngelGreen"                                                                            
 [73] "Laracuente.1"                                                                          
 [74] "Christina O'Regan"                                                                     
 [75] "Italian National Association of Archaeologists.1"                                      
 [76] "Janet Jones"                                                                           
 [77] "Henriette Roued-Cunliffe"                                                              
 [78] "Sheena Payne-Lunn"                                                                     
 [79] "Project Florence"                                                                      
 [80] "Monrepos - Archaeological Research Centre and Museum for Human Behavioural Evolution.1"
 [81] "MOLA.13"                                                                               
 [82] "Beverly Chiarulli"                                                                     
 [83] "Richard O'Brien"                                                                       
 [84] "Evaristo Gestoso Rodriguez"                                                            
 [85] "AMTTA.1"                                                                               
 [86] "Margie"                                                                                
 [87] "Sarah Bennett.1"                                                                       
 [88] "duncans"                                                                               
 [89] "John Worth"                                                                            
 [90] "Dana Goodburn-Brown.3"                                                                 
 [91] "Beth Pruitt.1"                                                                         
 [92] "NGO Archaeologica"                                                                     
 [93] "Philadelphia Archaeological Forum.3"                                                   
 [94] "Ashley McCuistion"                                                                     
 [95] "Marni Walter.1"                                                                        
 [96] "AVenovcevs"                                                                            
 [97] "AKOT Heritage"                                                                         
 [98] "nashcl"                                                                                
 [99] "michigan.1"                                                                            
[100] "David Standing.1"                                                                      
[101] "Robin Standring.1"                                                                     
[102] "Laura Griffin"                                                                         
[103] "John Worth.1"                                                                          
[104] "Bernard K. Means.1"                                                                    
[105] "Ian Richardson.1"                                                                      
[106] "aeadams83"                                                                             
[107] "cornelius"                                                                             
[108] "NGO Archaeologica.1"                                                                   
[109] "David Howell.1"                                                                        
[110] "hinesbuwf"                                                                             
[111] "eharchaeology"                                                                         
[112] "Damian Shiels"                                                                         
[113] "Peter Reavill.1"                                                                       
[114] "Peter Reavill.2"                                                                       
[115] "MOLA.16"                                                                               
[116] "Peter Reavill.3"                                                                       
[117] "Rachel Ives.1"                                                                         
[118] "Sophie Hay.1"                                                                          
[119] "Thomas Loebel"                                                                         
[120] "Mar�a Jos� Figuerero"                                                                  
[121] "Carmen Ting"                                                                           
[122] "Peter Reavill.4"                                                                       
[123] "RCAHMS.35"                                                                             
[124] "MOLA.19"                                                                               
[125] "transit_monkey"                                                                        
[126] "ralphj"                                                                                
[127] "Peter Reavill.5"                                                                       
[128] "Emily Noel-Paton"                                                                      
[129] "Peter Reavill.6"                                                                       
[130] "Tim Young.1"                                                                           
[131] "Declan Moore (Moore Group).1"                                                          
[132] "Liz Goodman"                                                                           
[133] "Gaye Nayton"                                                                           
[134] "John Worth.2"                                                                          
[135] "MOLA.24"                                                                               
[136] "alinelara"                                                                             
[137] "Claire Woodhead.7"                                                                     
[138] "RCAHMS.40"                                                                             
[139] "Peter Reavill.8"                                                                       
[140] "Cathy Dagg.1"                                                                          
[141] "Helen Williams.1"                                                                      
[142] "Charles Mount.1"                                                                       
[143] "murosv"                                                                                
[144] "Ferry"                                                                                 
[145] "Grace Krause.1"                                                                        
[146] "hinesbuwf.1"                                                                           
[147] "David Hunter"                                                                          
[148] "Peter Reavill.9"                                                                       

[[20]]
 [1] "Matt Law"               "alexism"                "SUrachi"               
 [4] "Rob Hedge"              "Claire Woodhead"        "Matt Law.1"            
 [7] "Rebecca"                "castlesandcoprolites"   "Matt Law.2"            
[10] "Dana Goodburn-Brown.1"  "Melonie Shier"          "David Osborne"         
[13] "eastoxford"             "DeborahFox"             "Liza Kavanagh"         
[16] "Joe Flatman"            "Pat Hadley"             "long1086"              
[19] "Hembo Pagi"             "Stu Eve"                "Andy Dufton"           
[22] "Sara Perry"             "Allison Mickel"         "Richard Madgwick"      
[25] "Alice Forward"          "Jacqui Mulville"        "castlesandcoprolites.1"
[28] "Don Henson.3"          

[[21]]
 [1] "CAT"                                                                                 
 [2] "CoDA_ucb.3"                                                                          
 [3] "bajrjobs.1"                                                                          
 [4] "Carly Hilts, Current Archaeology/Current World Archaeology"                          
 [5] "Samantha Brown"                                                                      
 [6] "bajrjobs.2"                                                                          
 [7] "bajrjobs.3"                                                                          
 [8] "Annie Partridge"                                                                     
 [9] "F.R.A.G."                                                                            
[10] "Christopher Merritt"                                                                 
[11] "Monrepos - Archaeological Research Centre and Museum for Human Behavioural Evolution"
[12] "Anne Jensen"                                                                         
[13] "Xtinebean"                                                                           
[14] "Nancy Grace"                                                                         
[15] "Carl Carlson-Drexler"                                                                
[16] "Matthew Jones"                                                                       
[17] "Carly Hilts, Current Archaeology/Current World Archaeology.1"                        
[18] "Terry Brock"                                                                         
[19] "MOLA.21"                                                                             
[20] "Robyn Antanovskii"                                                                   
[21] "izoken"                                                                              
[22] "Geoff Wyatt"                                                                         

[[22]]
 [1] "Darlene Applegate"                   "Sean Naleimaile"                    
 [3] "Mandy Ranslow"                       "Jamie Chad Brandon"                 
 [5] "John Lowe"                           "cdrexler"                           
 [7] "Nicole Bucchino"                     "Sean Naleimaile.1"                  
 [9] "cames"                               "Claire vanNierop"                   
[11] "gwynn henderson"                     "Glynis Irwin.1"                     
[13] "Philadelphia Archaeological Forum"   "Philadelphia Archaeological Forum.1"
[15] "Philadelphia Archaeological Forum.2" "Philadelphia Archaeological Forum.4"
[17] "John Lowe.1"                         "Mandy Ranslow.1"                    
[19] "Kurt Thomas Hunt"                    "Valerie M. J. Hall"                 
[21] "Rebecca Duggan"                      "Lucy Johnson"                       
[23] "Jamie Chad Brandon.1"               

[[23]]
 [1] "SuccinctBill"           "Doug"                   "CoDA_ucb"              
 [4] "Russell Alleen-Willems" "Shawn Graham"           "CoDA_ucb.1"            
 [7] "Leigh Anne"             "CoDA_ucb.2"             "CoDA_ucb.4"            
[10] "Beatrice Hopkinson"     "CoDA_ucb.5"             "Neil Gevaux"           
[13] "APAAME"                 "Andrew Reinhard"        "Ray Moore"             
[16] "cejo"                   "Doug.1"                 "Ulla Rajala"           
[19] "Eric Kansa"             "Shawn Graham.2"         "emmajaneoriordan"      
[22] "ADS"                    "Ethan Watrall"          "Andrew Reinhard.1"     
[25] "Kasia"                  "emmajaneoriordan.1"     "Kasia.1"               

[[24]]
 [1] "Francis Deblauwe"           "Jacq Matthews"             
 [3] "Kathryn E. Piquette"        "Bob Muckle"                
 [5] "Mark Patton"                "johnwillimas"              
 [7] "SuzieThomas"                "cristiana.2"               
 [9] "Kelly M"                    "Becky Wragg Sykes.1"       
[11] "Alex Nagel"                 "Udjahorresnet"             
[13] "Kathryn E. Piquette.1"      "Diefenerfer.1"             
[15] "Nancy Lovell"               "bupap"                     
[17] "terhi"                      "Henriette Roued-Cunliffe.1"
[19] "Axel G. Posluschny"         "Bob Muckle.1"              
[21] "ArchaeoAD.1"                "Melanie Pitkin"            

[[25]]
 [1] "Adam Corsini"        "Adam Corsini.1"      "Adam Corsini.3"     
 [4] "Adam Corsini.4"      "Adam Corsini.5"      "Marcel Dallinger"   
 [7] "Pippa Pearce"        "CooperCenter"        "Andrew Fetherston"  
[10] "Lucy Sawyer"         "Andrew Fetherston.1" "CooperCenter.1"     
[13] "Andrew Fetherston.2" "Andrew Fetherston.3" "fieldwork"          
[16] "Andrew Fetherston.4" "Andrew Fetherston.5"

[[26]]
 [1] "Diefenerfer"                "Angela Piccini"            
 [3] "Serra Head"                 "Ryan Swanson"              
 [5] "PalatineEastPotteryProject" "magago.1"                  
 [7] "Mathias Probst"             "Jacq Matthews.1"           
 [9] "Tanya Peres Lemons"         "cartvol.5"                 
[11] "Lorna Richardson.10"        "FlindersArchSoc"           
[13] "tkriek"                     "Polly Peterson"            
[15] "Vasilka Dimitrovska"       

[[27]]
 [1] "DavidAltoft"               "ssprince"                 
 [3] "Bairbre Mullee"            "Cayla Breiling"           
 [5] "Sally Rodgers"             "Sarah JaneHarknett"       
 [7] "Claire Woodhead.1"         "Alex Moseley"             
 [9] "Samantha Colclough"        "Amanda Clarke"            
[11] "talia_shay"                "Marni Walter"             
[13] "Archaeology UFPI - BRAZIL" "Cara Jones.1"             
[15] "sarah_may1.1"              "Charlotte Douglas.1"      
[17] "Bairbre Mullee.1"          "Samantha Barnes"          
[19] "Hayley Forsyth"            "Brian"                    
[21] "Joanne Robinson"           "LizzieW"                  
[23] "bthorn"                    "Mike Pitts"               
[25] "Andrew Mayfield"           "Andrew Mayfield.2"        
[27] "Brian.1"                  

[[28]]
 [1] "Alfred W. Bowers Laboratory of Anthropology"
 [2] "Stefano Costa"                              
 [3] "Penny Johnston"                             
 [4] "Frank Lynam"                                
 [5] "MOLA.4"                                     
 [6] "Lorna Richardson.9"                         
 [7] "Helen Sharp"                                
 [8] "FALSE"                                      
 [9] "Rachael Sparks.1"                           
[10] "Claire Woodhead.3"                          
[11] "Roman Baths Museum"                         
[12] "sven"                                       
[13] "Dawn McLaren.1"                             
[14] "RCAHMS.42"                                  

[[29]]
 [1] "Bob Clarke"                         "Chiz Harward (Urban Archaeology).1"
 [3] "Katy Meyers"                        "Rose"                              
 [5] "mwilliams"                          "Nicola Hembrey"                    
 [7] "Helen Goodchild"                    "Sue Harrington"                    
 [9] "Kasia.2"                            "jpalmer"                           
[11] "Stefan Sagrott"                    

[[30]]
 [1] "SusanneT"                     "adamrabinowitz"              
 [3] "Donna Yates"                  "Eleanor Ghey"                
 [5] "Keith Fitzpatrick-Matthews"   "phdiva"                      
 [7] "Keith Fitzpatrick-Matthews.1" "Laura Burnett.1"             
 [9] "Charlotte Dixon"              "Peter Reavill.7"             
[11] "Keith Fitzpatrick-Matthews.2" "Wendy Scott"                 
```              
#### Visualisation of author groups

Here is a static visualisation of the relationship between all the authors. We get a quick sense that there are distinctive groups, but it's too small to show author names which is a major limitation.
![static visualisation](figures/static.png)

Here is a [slightly interactive visualisation](http://htmlpreview.github.io/?https://github.com/benmarwick/dayofarchaeology/master/figures/d3net.html), where we can see names on the nodes (click on them to magnify the name) and inspect them in more detail by dragging them around. 

An even more interactive version can be downloaded [here](https://raw.github.com/benmarwick/dayofarchaeology/master/figures/g.graphml) (right-click -> save link as...) and opened in [Gephi](https://gephi.org/). 

Discussion and Conclusion
----
To return to the questions that motivated this little investigation, we can get some answers from what is missing from the results, as well as what is present. A reassuringly absent term is 'dinosaur', since this is often mistakenly associated with the archaeology. The last dino died out 65 million years ago, well before any people-like creatures were around (things get interesting to archaeologists around 2 million years ago). Key terms that are not prominent in the topics are pyramids, temples, whips and any kind of firearm. This suggests that a day in the life of the most popular Hollywood archaeologists has little in common with the people contributing to the day of archaeology. However, there is a small area of intersection since we see terms like 'treasure', 'gold', 'coins' and 'looting' in topic 8. This suggests that popular depictions of archaeologists as people who do things with treasure and valuable items are not completely wrong (for some lucky archaeologists, at least). We might now ask how are exactly do archaeologists get their gold, coins,  pots (the most frequently mentioned type of artefact) and other items that are less exotic but more commonly discussed during the day of archaeology? And once they've got these artefacts, what are they doing with them?

The obvious answers of survey and excavation feature prominantly in the topic model, especially topics 1 and 15. We also get some insights into other activities related to site discovery such as the use of geophysics and aerial photography. The context of site discovery and artefact recovery is frequently one where education and community engagement are priorities. For example, topic 10 inlcudes mentions of students and children, and topic 3 references learning, communities and kids. The discovery and recovery process is also quite labor intensive, especially when it comes to producing documentation. We see terms relating to documenting finds, such as forms, records and database across several topics.

Stepping away from the serious analysis of the topics for a moment, we do some simple text mining of the posts for some insights into how the fieldwork documented on the blog compares to fieldwork we seen in the movies. Here are a pair of charts that show total word counts for some words relating to fieldwork. This one shows the kinds of tools archaeologists write about. No whips or fedoras, but guns are mentioned a few times. [Closer inspection](http://www.dayofarchaeology.com/?s=gun&submit=) indicates that when archaeologists write about guns, they are usually talking about them as archaeological artefacts, not as persuaders. The high frequency of mentions of computers is no doubt due to their use at all stages of archaeological activity from the field to the lab and classroom.

![tools](figures/use.png)

Next we have a chart showing a sample of things that pose dangers to archaeologists in the field. Extremes of temperature are problematic, followed by dangerous animals and dangers of falling or becoming entombed. The problem of snakes is one that is shared by real word and film archaeologists, but Nazis seem to be uniquely a Hollywood concern. Mention of aliens is because of [this post by  Serra Head](http://www.dayofarchaeology.com/sometimes-you-just-have-to-debunk-it/) on her passion for public education and de-bunking stories of aliens building ancient monuments. 

![dangers](figures/fear.png)

Finally, we can mine the text to see what kinds of artefacts archaeologist typically collect during their fieldwork. Here we see that pottery is the winner, followed by other materials that are easily recognisable as raw materials for ancient food, tools and shelter. It seems that no-one took home a grail after their fieldwork, but finds of [treasure](http://www.dayofarchaeology.com/?s=treasure) (or museum work on them) are quite normal, especially from the Iron Age and Roman periods. 

![things](figures/things.png)

Those three charts are of course tongue-in-cheek (and the code is in the repository so you can make your own with any combination of other tools and dangers) and quick-and-dirty (for example I've not attempted to deal with homonymy, for example by distinguishing between hot as in spicy and hot as in summer weather). However, we can clearly see a few differences between popular images of archaeologists and how archaeologists describe themselves. 

Before we put the pickaxe away, there is one more question we can address with this kind of simple text mining. What's the balance of writing about males versus females? Or who features more often in the day of archaeology, female archaeologists or male archaeologists? We can get a bit of glimpse into this by looking at counts of male and female pronouns in the blog text. Here are all the gendered pronouns (ie. excluding 'it', 'they', 'we', etc), showing females in the lead:

![all pronouns](figures/gender1.png)

And here's the aggregate view, with all the different pronouns combined by gender. This confirms it: females are nearly twice as frequently mentioned than males. With the data available from this brief analysis it's difficult to know exactly what to make of this, is it because there are more female contributors to the day of archaeology blog than males? Or are there more females doing archaeology in general? Or do archaeologists tend to attribute a female gender to objects they anthropomorphize?

![aggregate pronouns](figures/gender2.png)

Now, back to the topic model. While field activities such as excavation and survey seem prominent in the topic model, we get relatively little insight into the post-excavation analytical process. Labs are mentioned in topics 3, 24, 29, but the other terms in these topics suggest the lab work relates to conservation and preservation. Topic 26 is the exception, as it seems to be include a Neolithic faunal analysis that involves isotope analysis. This topic also notable for its negative sentiment - 'difficult', this may be one reason why relatively few people are writing about lab analyses. Another reason might be that it can be hard to know what to write about in the middle of lab work, when the interpretations are still emerging from the fog of data. Compare this to the positive sentiment elsewhere, for example topics 13, 17, 18, 22, and 3 with 'interesting', 'happy', 'fun' and 'enjoy'. We might conclude that archaeology is generally a pleasant activity, except for the lab research bits. 

The post-excavation activities that are most prominent in the topic model relate to the conversation and display of artefacts and of course writing about the artefacts and their contexts for scholarly publication and public communication. Topics 8 and 21 mention museums, collections, exhibitions and related terms, which are also scattered throughout several other topics. Terms describing artefact conservation, such as 'conservation', 'cleaning', 'fragile' and 'corrosion' are distributed across a several topics. 

But the topic model has more than just excavation, survey, sites, artefacts and museums. A related post-excavation activity that frequently appears in the topic model can be described as heritage management. This is signalled by terms such as 'heritage', 'management', 'policy', 'law', 'council', government', 'rescue', 'client' and 'commercial'. These terms are most concentrated in topic 11 as well as appearing scattered throughout other topics. This is probably an aspect of archaeology that is least expected by the general public, where archaeologists work with governments and businesses to create plans and implement methods to protect archaeological sites and artefacts and make them accessible to the public. 

A final set of activities that is unexpected in the topic model is what we might describe as the digital humanities in archaeology. Digital humanities refers to [many things](http://tapor.ualberta.ca/taporwiki/index.php/How_do_you_define_Humanities_Computing_/_Digital_Humanities%3F) but one broad definition is [research that uses information technology as a central part of its methodology, for creating and/or processing data](http://digital.humanities.ox.ac.uk/Support/whatarethedh.aspx). In this topic model it is most prominently indicated by topic 4 with terms such as 'database', 'metadata', 'digital', 'open', 'access', 'image', 'video', 'text', 'app' and 'online'. On one hand, perhaps it's not surprising that people who chose to write for the day of archaeology blog are interested in digital humanities topics, since participation in blogging and social media are highly valued activities in the digital humanities. Perhaps archaeologists whose work intersects with digital humanities self-select to contribute to the day of archaeology blog, leading to over-representation in the topic model. On the other hand, we may be seeing a rising trend in the application of digital humanities approaches in archaeology (this essay is part of the trend, the text mining and topic modelling here are inspired directly by some of my favorite historians and literature scholars). Analysing next year's set of posts will help to test that idea.

To conclude, I set out to use some basic information retrieval methods to get some basic insights into what archaeologists do on a typical day (without having to closely read a vast amount of text). I downloaded all the posts on the day of archaeology blog from 2012 and 2013, generated a topic model and did some simple text mining. The results show some interesting differences and similarities between what real archaeologists do and what we see archaeologist-like characters do in Hollywood films. We've seen how fieldwork, education and community engagement are linked and widely discussed, and how mentions of lab analyses are rare. We've noted the activity of many archaeologists in conservation, curation and heritage management activities. Clearly there are a lot of archaeologists employed in these roles, which are perhaps not obvious career paths for people who graduate with a degree in archaeology (not obvious to the parents and friends of the graduates, at least). We've noted the appearance of the digital humanities in archaeology and wondered if it's an artefact of the sample or a real trend. 

I see a lot of what I expected in the results of this analysis. The activities represented in the topics are all things I tell undergraduates to expect as ways of making money and getting satisfaction from their training in archaeology. As an assistant professor of archaeology I didn't see many of my own day-to-day activities represented in the topics, there don't seem to be many academic archaeologists contributing to the day of archaeology. For the most part we are reading about the work of students and people involved in heritage management and museum projects. There are a few reasons that might explain this. First, academic archaeologists are simply much fewer in number compared to students and archaeologists working in consulting and management fields. Second, archaeologists working in heritage management might be more comfortable and willing to participate in outreach and public education projects like the day of archaeology. For academic archaeologists this may be a lower priority and a less familiar form of expression, compared to research and university teaching. Of course these are just speculations, though they might be tested with a focused survey. 

There's plenty more that could be done with a dataset like this one. For example, we could ask about what ancient time periods are most frequently written about, and what parts of the world are most represented and see how that changed between 2012 and 2013. We might ask what kinds of archaeological theories are people using when they're really doing archaeology, and how does that relate to the kind of archaeology they do. We could get a bit more sophisticated with statistics to refine the topic model and use some fancier text mining methods like named entity recognition, stylometrics, collocation analysis and sentiment analysis. All of these are fairly straightforward to implement in R, and doing so is left as an exercise to the reader (do let me know what you find!). 

As a final note, this has also been an experiement in [open science](http://en.wikipedia.org/wiki/Open_science) and [reproducible research](https://en.wikipedia.org/wiki/Reproducibility#Reproducible_research). Obviously this essay is not a highly scientific work, but it's completely open (ie. no login or subscription required). All the data and code to reproduce the results are freely available, for example on the day of archaeology blog and the code repository attached to this essay (and the software to run the code is aslo free and open source).  This approach to research is uncommon in archaeology, perhaps because of the relatively small scale of most archaeological research compared to fields where openness and reproducibility are more normal (ie. astronomy and genomics). It might be worth considering making this normal for archaeology, not least for the lowering of barriers to putting to work of archaeologists into the hands of the public, and helping them get a richer understanding of what the past was like, and how we know what it was like. 
