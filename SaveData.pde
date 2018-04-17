class SaveData {
  // Save data location & options when loading
  static final String filename = "save_data.tsv", options = "header, tsv";
  
  // Data table
  Table data;
  
  SaveData() {
    loadFile();
  }
  
  void loadFile() {
    File f = new File(dataPath(filename));
    if (!f.exists()) {
      createFile();
    }
    this.data = loadTable(filename, options);
  }
  
  void createFile() {
    Table tmp = new Table();
    tmp.addColumn("id");
    tmp.addColumn("name");
    tmp.addColumn("completedLevels");
    saveFile(tmp);
  }
  
  void saveFile(Table data) {
    saveTable(data, dataPath(filename), "tsv");
  }
  
  void saveFile() {
    saveTable(this.data, dataPath(filename), "tsv");
  }
  
  int getNextID() {
    // TODO: future implementation
    return 0;
  }
  
  void updatePlayerData(CharacterPlayer player) {
    // TODO: future implementation
  }
}
