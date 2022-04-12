MortalityLaw(x, Dx = NULL, Ex = NULL, mx = NULL, qx = NULL,
             law = NULL,
             opt.method = "LF2",
             parS = NULL,
             fit.this.x = x,
             custom.law = NULL,
             show = FALSE, ...)

install.packages("MortalityLaws")
library("MortalityLaws")

age_int=1
year_int=1
interval=paste0(age_int, "x", year_int)

#Mortality for South Korea
cntr= c("KOR")

#Mencari Dx
#Number of deaths between ages x and x+n
HMD_Dx=ReadHMD(what = "Dx", countries = cntr, interval = interval, 
               username = "youremail@gmail.com", 
               password = "yourpassword", save = FALSE)
HMD_Dx$years[16]
b=1666:1776
Dxdat=HMD_Dx$data[b,]
head(Dxdat)
Dx=Dxdat$Male
head(Dx)

#Mencari Ex
#Life expectancy at exact age x (in years)
HMD_Ex=ReadHMD(what = "Ex", countries = cntr, interval = interval, 
               username = "youremail@gmail.com", 
               password = "yourpassword", save = FALSE)
HMD_Ex$years[16]
b=1666:1776
Exdat=HMD_Ex$data[b,]
head(Exdat)
Ex=Exdat$Male
head(Ex)

#Mencari mx
#Central death rate between ages x and x+n
HMD_mx=ReadHMD(what = "mx", countries = cntr, interval = interval, 
               username = "youremail@gmail.com", 
               password = "the password", save = FALSE)
HMD_mx$years[16]
b=1666:1776
mxdat=HMD_mx$data[b,]

#Lifetable for Male
mx=mxdat$Male
mx

#Mencari lifetable makeham
x=0:110
M1=MortalityLaw(x = x, Dx = Dx, Ex = Ex, law = 'makeham')
M1
ls(M1)
coef(M1)
summary(M1)
head(fitted(M1))
plot(M1)
male_m=LifeTable(x = x, qx = fitted(M1))
head(male_m$lt)
write.csv(malem$lt, "lifetable male makeham.csv")

#Mencari lifetable gompertz
x=0:110
G1=MortalityLaw(x = x, Dx = Dx, Ex = Ex, law = 'gompertz')
G1
ls(G1)
coef(G1)
summary(G1)
head(fitted(G1))
plot(G1)
maleg=LifeTable(x = x, qx = fitted(G1))
write.csv(maleg$lt, "lifetable total gompertz.csv")

#Predict Lifetable for age 20 - 36
predict(M1, x =20:36)