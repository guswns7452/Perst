package com.clothes.perst.DTO;

/**
 * Female과 Male을 통합하기 위해 Style -> FolderID로 변경함
 */
public class ClothesFolder {
    public String gender;
    public String folderID;
    public String folderName;

    public ClothesFolder(){

    }
    public ClothesFolder(String gender, String folderName, String folderID) {
        this.gender = gender;
        this.folderName = folderName;
        this.folderID = folderID;
    }

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }

    public String getFolderID() {
        return folderID;
    }

    public void setFolderID(String folderID) {
        this.folderID = folderID;
    }

    public String getFolderName() {
        return folderName;
    }

    public void setFolderName(String folderName) {
        this.folderName = folderName;
    }
}
