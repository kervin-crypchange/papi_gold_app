enum OptTypeEnum { 
  updatePassword, updateClientInfo;

  static OptTypeEnum fromString(String? value){
    return OptTypeEnum.values.firstWhere(
      (e) => e.name == value,
      orElse: () => OptTypeEnum.updatePassword,
    );
  }

}
