class Account {
  int id; // Primary Id Key
  int index; // Seed Index
  String name;
  int lastAccess;
  bool selected;
  String address;
  String balance;

  Account(
      {this.id,
      this.index,
      this.name,
      this.lastAccess,
      this.selected,
      this.address,
      this.balance});
}
