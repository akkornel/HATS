#!/bin/sh
# vim: sw=4 ts=4 noet

# Check if a file has been mapped in to the input directory
if [ -z "$(ls -A /HATS/input 2>/dev/null)" ]; then
	echo "ERROR: The input directory is empty!  You must map a .fasta file into the directory at path \"/HATS/input/\"."
	echo "Example:"
	echo "    docker run --rm -v /path/on/host/hla_prot.fasta.3.54.0:/HATS/input/hla_prot.fasta.3.54.0 -v /path/on/host/output:/HATS/output/ HATS_container"
	exit 1
fi

# Check if the output directory is empty
if [ ! -z "$(ls -A /HATS/output)" ]; then
	echo "ERROR: The output directory is not empty!"
	echo "Please make sure the mapped output directory is not empty, and then re-run."
	exit 1
fi

# Run each script, in order:
scripts="runDPA1.pl
runDPB1.pl
runDQA1.pl
runDQB1.pl
runDRB1.pl
runDRB3.pl
runDRB4.pl
runDRB5.pl
runHlaA.pl
runHlaB.pl
runHlaC.pl
"
for script in ${scripts}; do
	echo "======== ${script} ========"
	perl "/HATS/${script}"
	exitcode=$?
	if [ "$exitcode" -ne 0 ]; then
		echo "ERROR: Script ${script} failed!"
		echo "For more information, see the script output above."
		echo "The other scripts will not run."
		exit 1
	fi
done

# All done!
echo "==== Scripts complete! ===="
echo "Check the output directory for the output files."
echo "You did remember to bind-mount an output directory, right?"
echo "Example:"
echo "    docker run --rm -v /path/on/host/hla_prot.fasta.3.54.0:/HATS/input/hla_prot.fasta.3.54.0 -v /path/on/host/output:/HATS/output/ HATS_container"
