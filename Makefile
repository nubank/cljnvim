OSCONFIGPATH := ~/.config/nvim
CONFIG := ./config/init.vim

clean:
	@rm ${OSCONFIGPATH} -rf

prepare: clean
	mkdir -p ${OSCONFIGPATH}
	mv ${CONFIG} ${OSCONFIGPATH}
	nvim -u $(OSCONFIGPATH)/init.vim

nvim:
	nvim -u ${OSCONFIGPATH}/init.vim

init-vim:
	nix build .#init-vim
	cat ./result >> ${CONFIG}
