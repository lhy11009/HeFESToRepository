# Compiles HeFESTo

CFT     = gfortran
LDR     = gfortran
FFLAGS  = -ffixed-line-length-132 -fimplicit-none -fno-automatic -Ofast -g -fcheck=all -Wall -fbacktrace
#  Link to NLOPT library which can be downloaded and installed from https://nlopt.readthedocs.io/en/latest/
LFLAGS = -lnlopt -lm
COMMAND = main
#  Get LAPACK and BLAS
LIB1 =  -L${MKLROOT}/lib/intel64 -Wl,--no-as-needed -lmkl_gf_lp64 -lmkl_sequential -lmkl_core -lpthread -lm -ldl
INCLUDE1 =  -I${MKLROOT}/include
# PATH for NLOPT
LIB_NLOPT = -L/home/lochy/Softwares/NLopt/nlopt-2.7.1/install/lib
INCLUDE_NLOPT = -I${NLOPT_INCLUDE_PATH}

.f.o :
	$(CFT) $(INCLUDE1) $(INCLUDE_NLOPT) $(LIB1) $(LIB_NLOPT) $(FFLAGS) $*.f -c

MAIN = main.o

SUBS = \
readin.o formula.o atomset.o func.o nform.o \
gspec.o volume.o therm.o thermg.o parset.o pressure.o \
gamset.o dfunc.o cp.o Etherm.o Ctherm.o Ftherm.o \
dossetup.o Heat.o Ener.o Helm.o thetacal.o \
svdsub.o matprint.o ourlog.o writeout.o \
cformula.o idchar.o nmchar.o transpose.o newfrm3.o lagscomp.o \
therml.o aliqset.o volumel.o pressurel.o Ftotsubl.o \
parse.o dkron.o spinrem.o entrop.o \
qr19.o vred.o const.o tform.o valid.o \
depth.o vdos.o vcon.o vdosm.o moms.o \
Ztherm.o Wav.o PTfind.o \
regread.o sitered.o back.o Ftotsub.o Ftotsubg.o sform.o tracesub.o \
lagcomp.o phaseadd.o setup.o petsub.o physub.o \
gibmin.o restore.o newfrm.o qcalc.o ssave.o \
landau.o landauqr.o landaucr.o hugoniot.o bserch.o neville.o \
chkderlps.o hessian.o hessmin.o hessfunc.o hesspot.o \
nlmin_L.o myfunc.o myconstraint.o validc.o cage.o caget.o cages.o \
nlfeas.o nlfeasopt.o myfeas.o myconfeas.o \
zeroin.o zeroint.o nlmin_V.o myvol.o \
tlindeman.o asqrt.o sfunc.o dsfunc.o myvoll.o nlmin_VL.o \
Tspin.o vfunc.o dvfunc.o Prange.o Tlfeas.o Plfeas.o hev.o stishtran.o thermlel.o thermlig.o \
dfac.o dsort.o dqagse.o d1mach.o dqelg.o dqk21.o dqpsrt.o hillert.o


$(COMMAND): $(MAIN) $(SUBS)
	$(LDR) $(LIB1) $(LIB_NLOPT) $(LFLAGS) -o $(COMMAND) $(MAIN) $(SUBS)
