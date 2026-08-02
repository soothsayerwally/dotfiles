{ pkgs, ... }: {
  home.packages = with pkgs; [
    calibre
  ];
  xdg.desktopEntries = {
   "calibre-ebook-viewer" = {
     name = "E-book Viewer";
     exec = "calibre-shortcut-placeholder"; 
     noDisplay = true;                      
   };
   "calibre-ebook-edit" = {
     name = "E-book Editor";
     exec = "calibre-shortcut-placeholder";
     noDisplay = true;
   };
   "calibre-lrfviewer" = {
     name = "LRF Viewer";
     exec = "calibre-shortcut-placeholder";
     noDisplay = true;
   };
 };   
}
