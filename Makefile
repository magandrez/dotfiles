CONFIGS := bin config fonts git gpg misc screen x

all: $(CONFIGS)
$(CONFIGS):
	stow $@

%:
    @: stow $@


.PHONY: % all $(CONFIGS)
