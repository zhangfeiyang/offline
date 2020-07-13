#how to use?
## If you want to do the full detector simulation

	python tut_detsim.py --loglevel Error --evtmax 5000 --no-gdml -seed 1374 --output nusol-5000.root --user-output user-nusol-5000.root nusol --type Be7 --material LS --volume pTarget
Use --type to specify what neutrino events type: pp,Be7,Be7_862,Be7_384,B8,N13,O15,F17,pep,hep

## If you just need the elastic scattering spectrum wtihout detector effect

You can use the independent executables, but you need the **root** and **clhep** installed. Usage:

	cd ../app/
	make
	source ./setup.sh
	./NuSolGen.exe -n 100 -source Be7
