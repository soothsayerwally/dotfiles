{ ... }: {
  # Basic Git configuration
  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "Krishang";
        email = "krishangnayanbhagawati@gmail.com";
      };
    };
  };
}

