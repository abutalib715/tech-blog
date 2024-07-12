package com.tech.blog.helper;

import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStream;

public class Helper {
    public static boolean deleteFile(String path) {
        boolean isDeleted = false;
        try {
            File file = new File(path);
            isDeleted = file.delete();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return isDeleted;
    }

    public static boolean uploadFile(InputStream inputStream, String path) {
        boolean isUploaded = false;
        try {
            byte b[] = new byte[inputStream.available()];
            inputStream.read(b);

            FileOutputStream fileOutputStream = new FileOutputStream(path);
            fileOutputStream.write(b);
            fileOutputStream.flush();
            fileOutputStream.close();
            isUploaded = true;
        } catch (Exception e) {
            e.printStackTrace();
        }

        return isUploaded;
    }
}
