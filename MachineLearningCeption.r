#This program checks all combinations of parameters for a model to see which is the best.
#It currently only works for parameter lists 15 or fewer.
#Simply enter your parameter list into modeling_list and enter the number of parameters into parameterNum.
#Then do a find and replace for "#TEMPLATE" with your for loop containing your model and your auc calculation.

modeling_list <- c()
best_auc <- 0
best_model <- c()
parameterNum <- 9
for (loop in 2:parameterNum)
{
print(paste("Creating ", parameterNum, "C", loop, " models."))


#2
if (loop==2)
{
for (o in 1:(parameterNum-1))
{
for (p in (o+1):parameterNum)
{
modeling_variables <- c(modeling_list[o], modeling_list[p])

#TEMPLATE

if(auc > best_auc)
{best_auc <- auc
best_model <- modeling_variables}
}}}


#3
else if (loop==3)
{
for (n in 1:(parameterNum-2))
{
for (o in (n+1):(parameterNum-1))
{
for (p in (o+1):parameterNum)
{
modeling_variables <- c(modeling_list[n], modeling_list[o], modeling_list[p])

#TEMPLATE

if(auc > best_auc)
{best_auc <- auc
best_model <- modeling_variables}
}}}}


#4
else if (loop==4)
{
for (m in 1:(parameterNum-3))
{
for (n in (m+1):(parameterNum-2))
{
for (o in (n+1):(parameterNum-1))
{
for (p in (o+1):parameterNum)
{
modeling_variables <- c(modeling_list[m], modeling_list[n], modeling_list[o], modeling_list[p])

#TEMPLATE

if(auc > best_auc)
{best_auc <- auc
best_model <- modeling_variables}
}}}}}


#5
else if (loop==5)
{
for (l in 1:(parameterNum-4))
{
for (m in (l+1):(parameterNum-3))
{
for (n in (m+1):(parameterNum-2))
{
for (o in (n+1):(parameterNum-1))
{
for (p in (o+1):parameterNum)
{
modeling_variables <- c(modeling_list[l], modeling_list[m], modeling_list[n], modeling_list[o], modeling_list[p])

#TEMPLATE

if(auc > best_auc)
{best_auc <- auc
best_model <- modeling_variables}
}}}}}}


#6
else if (loop==6)
{
for (k in 1:(parameterNum-5))
{
for (l in (k+1):(parameterNum-4))
{
for (m in (l+1):(parameterNum-3))
{
for (n in (m+1):(parameterNum-2))
{
for (o in (n+1):(parameterNum-1))
{
for (p in (o+1):parameterNum)
{
modeling_variables <- c(modeling_list[k], modeling_list[l], modeling_list[m], modeling_list[n], modeling_list[o], modeling_list[p])

#TEMPLATE

if(auc > best_auc)
{best_auc <- auc
best_model <- modeling_variables}
}}}}}}}


#7
else if (loop==7)
{
for (j in 1:(parameterNum-6))
{
for (k in (j+1):(parameterNum-5))
{
for (l in (k+1):(parameterNum-4))
{
for (m in (l+1):(parameterNum-3))
{
for (n in (m+1):(parameterNum-2))
{
for (o in (n+1):(parameterNum-1))
{
for (p in (o+1):parameterNum)
{
modeling_variables <- c(modeling_list[j], modeling_list[k], modeling_list[l], modeling_list[m], modeling_list[n], modeling_list[o], modeling_list[p])

#TEMPLATE

if(auc > best_auc)
{best_auc <- auc
best_model <- modeling_variables}
}}}}}}}}


#8
else if (loop==8)
{
for (i in 1:(parameterNum-7))
{
for (j in (i+1):(parameterNum-6))
{
for (k in (j+1):(parameterNum-5))
{
for (l in (k+1):(parameterNum-4))
{
for (m in (l+1):(parameterNum-3))
{
for (n in (m+1):(parameterNum-2))
{
for (o in (n+1):(parameterNum-1))
{
for (p in (o+1):parameterNum)
{
modeling_variables <- c(modeling_list[i], modeling_list[j], modeling_list[k], modeling_list[l], modeling_list[m], modeling_list[n], modeling_list[o], modeling_list[p])

#TEMPLATE

if(auc > best_auc)
{best_auc <- auc
best_model <- modeling_variables}
}}}}}}}}}


#9
else if (loop==9)
{
for (h in 1:(parameterNum-8))
{
for (i in (h+1):(parameterNum-7))
{
for (j in (i+1):(parameterNum-6))
{
for (k in (j+1):(parameterNum-5))
{
for (l in (k+1):(parameterNum-4))
{
for (m in (l+1):(parameterNum-3))
{
for (n in (m+1):(parameterNum-2))
{
for (o in (n+1):(parameterNum-1))
{
for (p in (o+1):parameterNum)
{
modeling_variables <- c(modeling_list[h], modeling_list[i], modeling_list[j], modeling_list[k], modeling_list[l], modeling_list[m], modeling_list[n], modeling_list[o], modeling_list[p])

#TEMPLATE

if(auc > best_auc)
{best_auc <- auc
best_model <- modeling_variables}
}}}}}}}}}}


#10
else if (loop==10)
{
for (g in 1:(parameterNum-9))
{
for (h in (g+1):(parameterNum-8))
{
for (i in (h+1):(parameterNum-7))
{
for (j in (i+1):(parameterNum-6))
{
for (k in (j+1):(parameterNum-5))
{
for (l in (k+1):(parameterNum-4))
{
for (m in (l+1):(parameterNum-3))
{
for (n in (m+1):(parameterNum-2))
{
for (o in (n+1):(parameterNum-1))
{
for (p in (o+1):parameterNum)
{
modeling_variables <- c(modeling_list[g], modeling_list[h], modeling_list[i], modeling_list[j], modeling_list[k], modeling_list[l], modeling_list[m], modeling_list[n], modeling_list[o], modeling_list[p])

#TEMPLATE

if(auc > best_auc)
{best_auc <- auc
best_model <- modeling_variables}
}}}}}}}}}}}


#11
else if (loop==11)
{
for (f in 1:(parameterNum-10))
{
for (g in (f+1):(parameterNum-9))
{
for (h in (g+1):(parameterNum-8))
{
for (i in (h+1):(parameterNum-7))
{
for (j in (i+1):(parameterNum-6))
{
for (k in (j+1):(parameterNum-5))
{
for (l in (k+1):(parameterNum-4))
{
for (m in (l+1):(parameterNum-3))
{
for (n in (m+1):(parameterNum-2))
{
for (o in (n+1):(parameterNum-1))
{
for (p in (o+1):parameterNum)
{
modeling_variables <- c(modeling_list[f], modeling_list[g], modeling_list[h], modeling_list[i], modeling_list[j], modeling_list[k], modeling_list[l], modeling_list[m], modeling_list[n], modeling_list[o], modeling_list[p])

#TEMPLATE

if(auc > best_auc)
{best_auc <- auc
best_model <- modeling_variables}
}}}}}}}}}}}}


#12
else if (loop==12)
{
for (e in 1:(parameterNum-11))
{
for (f in (e+1):(parameterNum-10))
{
for (g in (f+1):(parameterNum-9))
{
for (h in (g+1):(parameterNum-8))
{
for (i in (h+1):(parameterNum-7))
{
for (j in (i+1):(parameterNum-6))
{
for (k in (j+1):(parameterNum-5))
{
for (l in (k+1):(parameterNum-4))
{
for (m in (l+1):(parameterNum-3))
{
for (n in (m+1):(parameterNum-2))
{
for (o in (n+1):(parameterNum-1))
{
for (p in (o+1):parameterNum)
{
modeling_variables <- c(modeling_list[e], modeling_list[f], modeling_list[g], modeling_list[h], modeling_list[i], modeling_list[j], modeling_list[k], modeling_list[l], modeling_list[m], modeling_list[n], modeling_list[o], modeling_list[p])

#TEMPLATE

if(auc > best_auc)
{best_auc <- auc
best_model <- modeling_variables}
}}}}}}}}}}}}}


#13
else if (loop==13)
{
for (d in 1:(parameterNum-12))
{
for (e in (d+1):(parameterNum-11))
{
for (f in (e+1):(parameterNum-10))
{
for (g in (f+1):(parameterNum-9))
{
for (h in (g+1):(parameterNum-8))
{
for (i in (h+1):(parameterNum-7))
{
for (j in (i+1):(parameterNum-6))
{
for (k in (j+1):(parameterNum-5))
{
for (l in (k+1):(parameterNum-4))
{
for (m in (l+1):(parameterNum-3))
{
for (n in (m+1):(parameterNum-2))
{
for (o in (n+1):(parameterNum-1))
{
for (p in (o+1):parameterNum)
{
modeling_variables <- c(modeling_list[d], modeling_list[e], modeling_list[f], modeling_list[g], modeling_list[h], modeling_list[i], modeling_list[j], modeling_list[k], modeling_list[l], modeling_list[m], modeling_list[n], modeling_list[o], modeling_list[p])

#TEMPLATE

if(auc > best_auc)
{best_auc <- auc
best_model <- modeling_variables}
}}}}}}}}}}}}}}


#14
else if (loop==14)
{
for (zz in 1:(parameterNum-13))
{
for (d in (zz+1):(parameterNum-12))
{
for (e in (d+1):(parameterNum-11))
{
for (f in (e+1):(parameterNum-10))
{
for (g in (f+1):(parameterNum-9))
{
for (h in (g+1):(parameterNum-8))
{
for (i in (h+1):(parameterNum-7))
{
for (j in (i+1):(parameterNum-6))
{
for (k in (j+1):(parameterNum-5))
{
for (l in (k+1):(parameterNum-4))
{
for (m in (l+1):(parameterNum-3))
{
for (n in (m+1):(parameterNum-2))
{
for (o in (n+1):(parameterNum-1))
{
for (p in (o+1):parameterNum)
{
modeling_variables <- c(modeling_list[zz], modeling_list[d], modeling_list[e], modeling_list[f], modeling_list[g], modeling_list[h], modeling_list[i], modeling_list[j], modeling_list[k], modeling_list[l], modeling_list[m], modeling_list[n], modeling_list[o], modeling_list[p])

#TEMPLATE

if(auc > best_auc)
{best_auc <- auc
best_model <- modeling_variables}
}}}}}}}}}}}}}}}


#15
else if (loop==15)
{
for (yy in 1:(parameterNum-14))
{
for (zz in (yy+1):(parameterNum-13))
{
for (d in (zz+1):(parameterNum-12))
{
for (e in (d+1):(parameterNum-11))
{
for (f in (e+1):(parameterNum-10))
{
for (g in (f+1):(parameterNum-9))
{
for (h in (g+1):(parameterNum-8))
{
for (i in (h+1):(parameterNum-7))
{
for (j in (i+1):(parameterNum-6))
{
for (k in (j+1):(parameterNum-5))
{
for (l in (k+1):(parameterNum-4))
{
for (m in (l+1):(parameterNum-3))
{
for (n in (m+1):(parameterNum-2))
{
for (o in (n+1):(parameterNum-1))
{
for (p in (o+1):parameterNum)
{
modeling_variables <- c(modeling_list[yy], modeling_list[zz], modeling_list[d], modeling_list[e], modeling_list[f], modeling_list[g], modeling_list[h], modeling_list[i], modeling_list[j], modeling_list[k], modeling_list[l], modeling_list[m], modeling_list[n], modeling_list[o], modeling_list[p])

#TEMPLATE

if(auc > best_auc)
{best_auc <- auc
best_model <- modeling_variables}
}}}}}}}}}}}}}}}}


#Closing the outer loop
}