with (import <nixpkgs>) {};

vscode.overrideDerivation (oldAttrs: rec {
    name = "vscode-px-${version}";
    version = "1.0";
    apps = with haskellPackages; with pkgs; [
       #
       # Haskell
       #
       intero
       QuickCheck 
       stack-run
       cabal-install
       ghc
       ghc-mod
       happy
       hasktags
       hindent
       hlint
       hoogle
       phoityne-vscode
       #
       # Python
       #
       python27Packages.rope
       python3
       python34Packages.autopep8
       python34Packages.elpy
       python34Packages.flake8
       python34Packages.importmagic
       python34Packages.ipython
       python34Packages.jedi
       python34Packages.virtualenv
    ];

    buildInputs = (with pkgs; with haskellPackages; oldAttrs.buildInputs ++ apps);

    installPhase = oldAttrs.installPhase + ''
      wrapProgram $out/bin/code --prefix PATH : ${lib.makeBinPath apps}
    '';
  })
