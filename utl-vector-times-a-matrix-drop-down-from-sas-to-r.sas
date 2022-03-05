%let pgm=utl-vector-times-a-matrix-drop-down-from-sas-to-r;

Vector times a matrix drop down from sas to r

github
https://tinyurl.com/4krchkfb
https://github.com/rogerjdeangelis/utl-vector-times-a-matrix-drop-down-from-sas-to-r

StackOverflow
https://tinyurl.com/mt5vas2t
https://stackoverflow.com/questions/71217009/inner-product-between-a-table-and-a-column-in-sas

Related repos
https://tinyurl.com/2drm72br
https://github.com/rogerjdeangelis?tab=repositories&q=vector+matrix+in%3Atitle&type=&language=&sort=

Drop down macros on end

options valivarnames=upcase;

/*                   _
(_)_ __  _ __  _   _| |_
| | `_ \| `_ \| | | | __|
| | | | | |_) | |_| | |_
|_|_| |_| .__/ \__,_|\__|
        |_|
*/

libname sd1 "d:/sd1";

DATA sd1.mat ;
    input v1 v2 v3 ;
    datalines ;
1  2   3
2  4   6
3  6   9
4  8  12
5 10  15
    ;
RUN ;

DATA sd1.vec ;
    length Variable $3. ;
    input Variable $ coef ;
    datalines ;
v1 0.1
v2 0.2
v3 0.3
    ;
RUN ;

/**************************************************************************************************************************/
/*  _                   _                                                                                                 */
/* (_)_ __  _ __  _   _| |_                                                                                               */
/* | | `_ \| `_ \| | | | __|                                                                                              */
/* | | | | | |_) | |_| | |_                                                                                               */
/* |_|_| |_| .__/ \__,_|\__|                                                                                              */
/*         |_|                                                                                                            */
/*                                                                                                                        */
/* Up to 40 obs from SD1.MAT total obs=5 05MAR2022:11:33:31                                                               */
/*                                                                                                                        */
/* Obs    V1    V2    V3                                                                                                  */
/*                                                                                                                        */
/*  1      1     2     3                                                                                                  */
/*  2      2     4     6                                                                                                  */
/*  3      3     6     9                                                                                                  */
/*  4      4     8    12                                                                                                  */
/*  5      5    10    15                                                                                                  */
/*                                                                                                                        */
/* Up to 40 obs from SD1.VEC total obs=3 05MAR2022:11:33:45                                                               */
/*                                                                                                                        */
/* Obs    VARIABLE    COEF                                                                                                */
/*                                                                                                                        */
/*  1        v1        0.1                                                                                                */
/*  2        v2        0.2                                                                                                */
/*  3        v3        0.3                                                                                                */
/*                                                                                                                        */
/*   _ __ _   _| | ___  ___                                                                                               */
/*  | `__| | | | |/ _ \/ __|                                                                                              */
/*  | |  | |_| | |  __/\__ \                                                                                              */
/*  |_|   \__,_|_|\___||___/                                                                                              */
/*                                                                                                                        */
/* calculate it by v1*0.1 + v2*0.2 + v3*0.3 by each row.                                                                  */
/*                                                                                                                        */
/* 1*0.1 +  2*0.2 +  3*0.3   = 1.4                                                                                        */
/* 2*0.1 +  4*0.2 +  6*0.3   = 2.8                                                                                        */
/* 3*0.1 +  6*0.2 +  9*0.3   = 4.2                                                                                        */
/* 4*0.1 +  8*0.2 + 12*0.3   = 5.6                                                                                        */
/* 5*0.1 + 10*0.2 + 15*0.3     = 7                                                                                        */
/*              _               _                                                                                         */
/*   ___  _   _| |_ _ __  _   _| |_                                                                                       */
/*  / _ \| | | | __| `_ \| | | | __|                                                                                      */
/* | (_) | |_| | |_| |_) | |_| | |_                                                                                       */
/*  \___/ \__,_|\__| .__/ \__,_|\__|                                                                                      */
/*                 |_|                                                                                                    */
/*                                                                                                                        */
/* Up to 40 obs WORK.WANT total obs=5 05MAR2022:11:41:52                                                                  */
/*                                                                                                                        */
/* Obs    COEF                                                                                                            */
/*                                                                                                                        */
/*  1      1.4                                                                                                            */
/*  2      2.8                                                                                                            */
/*  3      4.2                                                                                                            */
/*  4      5.6                                                                                                            */
/*  5      7.0                                                                                                            */
/*                                                                                                                        */
/**************************************************************************************************************************/

/*         _       _   _
 ___  ___ | |_   _| |_(_) ___  _ __
/ __|/ _ \| | | | | __| |/ _ \| `_ \
\__ \ (_) | | |_| | |_| | (_) | | | |
|___/\___/|_|\__,_|\__|_|\___/|_| |_|

*/

%utl_rbegin;
parmcards4;
library(haven);
library(SASxport);
mat<-t(as.matrix(read_sas("d:/sd1/mat.sas7bdat")));
vec<-t(as.vector(read_sas("d:/sd1/vec.sas7bdat"))[,2]);
mat;
vec;
want<-as.data.frame(t(vec %*% mat));
want;
write.xport(want,file="d:/xpt/want.xpt",autogen.formats = FALSE);
;;;;
%utl_rend;

libname xpt xport "d:/xpt/want.xpt";

proc print data=xpt.want;
run;quit;

data want;
  set xpt.want;
run;quit;

/*
 _ __ ___   __ _  ___ _ __ ___  ___
| `_ ` _ \ / _` |/ __| `__/ _ \/ __|
| | | | | | (_| | (__| | | (_) \__ \
|_| |_| |_|\__,_|\___|_|  \___/|___/

*/

%utl_rbegin;
parcards4;
%macro utl_rbegin;
%utlfkil(c:/temp/r_pgm.r);
%utlfkil(c:/temp/r_pgm.log);
filename ft15f001 "c:/temp/r_pgm.r";
%mend utl_rbegin;

%macro utl_rend(returnvar=N);
* EXECUTE THE R PROGRAM;
options noxwait noxsync;
filename rut pipe "D:\r412\R\R-4.1.2\bin\R.exe --vanilla --quiet --no-save < c:/temp/r_pgm.r 2> c:/temp/r_pgm.log";
run;quit;
  data _null_;
    file print;
    infile rut recfm=v lrecl=32756;
    input;
    put _infile_;
    putlog _infile_;
  run;
  filename ft15f001 clear;
  * use the clipboard to create macro variable;
  %if %upcase(%substr(&returnVar.,1,1)) ne N %then %do;
    filename clp clipbrd ;
    data _null_;
     length txt $200;
     infile clp;
     input;
     putlog "macro variable &returnVar = " _infile_;
     call symputx("&returnVar.",_infile_,"G");
    run;quit;
  %end;
data _null_;
  file print;
  infile rut;
  input;
  put _infile_;
  putlog _infile_;
run;quit;
data _null_;
  infile "c:/temp/r_pgm.log";
  input;
  putlog _infile_;
run;quit;
%mend utl_rend;
