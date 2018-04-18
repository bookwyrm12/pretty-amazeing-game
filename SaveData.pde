class SaveData {
  // Save data location & options when loading
  static final String filename = "save_data.tsv", loadOptions = "header, tsv", saveOptions = "tsv";
  
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
    this.data = loadTable(filename, loadOptions);
  }
  
  void createFile() {
    Table tmp = new Table();
    tmp.addColumn("id");
    tmp.addColumn("name");
    tmp.addColumn("completedLevel");
    saveFile(tmp);
  }
  
  void saveFile(Table data) {
    saveTable(data, dataPath(filename), saveOptions);
  }
  
  void saveFile() {
    saveTable(this.data, dataPath(filename), saveOptions);
  }
  
  int getNextID() {
    // TODO: future implementation
    return 0;
  }
  
  void loadPlayerData(CharacterPlayer player) {
    // Load existing rows
    for (TableRow r : this.data.findRows(str(player.id), "id")) {
      int level = r.getInt("completedLevel");
      if (!player.completedLevels.hasValue(level)) {
        player.completedLevels.append(level);
      }
    }
  }
  
  void updatePlayerData(CharacterPlayer player) {
    // Remove existing rows
    for (int i = 0; i < this.data.getRowCount(); ++i) {
      TableRow r = this.data.getRow(i);
      if (r.getInt("id") == player.id) {
        this.data.removeRow(i);
      }
    }
    
    // Save new rows
    for (Integer i : player.completedLevels) {
      TableRow r = this.data.addRow();
      r.setInt("id", player.id);
      r.setString("name", "");
      r.setInt("completedLevel", i);
    }
    
    // Save to disk
    this.saveFile();
  }
}
