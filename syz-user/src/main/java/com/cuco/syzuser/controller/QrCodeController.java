package com.cuco.syzuser.controller;

import com.cuco.syzuser.service.QrCodeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/qrcode")
@CrossOrigin(origins = "*")
public class QrCodeController {

    @Autowired
    private QrCodeService qrCodeService;

    /**
     * 生成普通二维码
     * 
     * @param content 二维码内容（可选，默认为登录页面URL）
     * @param width 二维码宽度（可选，默认300）
     * @param height 二维码高度（可选，默认300）
     * @return 二维码PNG图片
     */
    @GetMapping("/generate")
    public ResponseEntity<byte[]> generateQrCode(
            @RequestParam(required = false) String content,
            @RequestParam(required = false) Integer width,
            @RequestParam(required = false) Integer height) {
        try {
            byte[] qrCodeImage = qrCodeService.generateQrCode(content, width, height);
            
            HttpHeaders headers = new HttpHeaders();
            headers.setContentType(MediaType.IMAGE_PNG);
            headers.setContentLength(qrCodeImage.length);
            headers.set("Content-Disposition", "inline; filename=qrcode.png");
            
            return new ResponseEntity<>(qrCodeImage, headers, HttpStatus.OK);
        } catch (Exception e) {
            e.printStackTrace();
            return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    /**
     * 生成带Logo的二维码
     * 
     * @param content 二维码内容（可选，默认为登录页面URL）
     * @param width 二维码宽度（可选，默认300）
     * @param height 二维码高度（可选，默认300）
     * @param logoUrl Logo图片URL（可选，如果不提供则使用默认Logo）
     * @return 二维码PNG图片
     */
    @GetMapping("/generate-with-logo")
    public ResponseEntity<byte[]> generateQrCodeWithLogo(
            @RequestParam(required = false) String content,
            @RequestParam(required = false) Integer width,
            @RequestParam(required = false) Integer height,
            @RequestParam(required = false) String logoUrl) {
        try {
            byte[] qrCodeImage = qrCodeService.generateQrCodeWithLogo(content, width, height, logoUrl);
            
            HttpHeaders headers = new HttpHeaders();
            headers.setContentType(MediaType.IMAGE_PNG);
            headers.setContentLength(qrCodeImage.length);
            headers.set("Content-Disposition", "inline; filename=qrcode-with-logo.png");
            
            return new ResponseEntity<>(qrCodeImage, headers, HttpStatus.OK);
        } catch (Exception e) {
            e.printStackTrace();
            return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    /**
     * 生成登录页面二维码（快捷接口）
     * 
     * @param withLogo 是否带Logo（可选，默认false）
     * @return 二维码PNG图片
     */
    @GetMapping("/login")
    public ResponseEntity<byte[]> generateLoginQrCode(
            @RequestParam(required = false, defaultValue = "false") boolean withLogo) {
        try {
            byte[] qrCodeImage = qrCodeService.generateLoginQrCode(withLogo);
            
            HttpHeaders headers = new HttpHeaders();
            headers.setContentType(MediaType.IMAGE_PNG);
            headers.setContentLength(qrCodeImage.length);
            headers.set("Content-Disposition", "inline; filename=login-qrcode.png");
            
            return new ResponseEntity<>(qrCodeImage, headers, HttpStatus.OK);
        } catch (Exception e) {
            e.printStackTrace();
            return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    /**
     * POST方式生成普通二维码（支持复杂内容）
     */
    @PostMapping("/generate")
    public ResponseEntity<byte[]> generateQrCodePost(@RequestBody GenerateQrCodeRequest request) {
        try {
            byte[] qrCodeImage = qrCodeService.generateQrCode(
                request.getContent(), 
                request.getWidth(), 
                request.getHeight()
            );
            
            HttpHeaders headers = new HttpHeaders();
            headers.setContentType(MediaType.IMAGE_PNG);
            headers.setContentLength(qrCodeImage.length);
            headers.set("Content-Disposition", "inline; filename=qrcode.png");
            
            return new ResponseEntity<>(qrCodeImage, headers, HttpStatus.OK);
        } catch (Exception e) {
            e.printStackTrace();
            return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    /**
     * POST方式生成带Logo的二维码（支持复杂内容）
     */
    @PostMapping("/generate-with-logo")
    public ResponseEntity<byte[]> generateQrCodeWithLogoPost(@RequestBody GenerateQrCodeRequest request) {
        try {
            byte[] qrCodeImage = qrCodeService.generateQrCodeWithLogo(
                request.getContent(), 
                request.getWidth(), 
                request.getHeight(),
                request.getLogoUrl()
            );
            
            HttpHeaders headers = new HttpHeaders();
            headers.setContentType(MediaType.IMAGE_PNG);
            headers.setContentLength(qrCodeImage.length);
            headers.set("Content-Disposition", "inline; filename=qrcode-with-logo.png");
            
            return new ResponseEntity<>(qrCodeImage, headers, HttpStatus.OK);
        } catch (Exception e) {
            e.printStackTrace();
            return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    /**
     * 请求参数DTO
     */
    public static class GenerateQrCodeRequest {
        private String content;
        private Integer width;
        private Integer height;
        private String logoUrl;

        public String getContent() {
            return content;
        }

        public void setContent(String content) {
            this.content = content;
        }

        public Integer getWidth() {
            return width;
        }

        public void setWidth(Integer width) {
            this.width = width;
        }

        public Integer getHeight() {
            return height;
        }

        public void setHeight(Integer height) {
            this.height = height;
        }

        public String getLogoUrl() {
            return logoUrl;
        }

        public void setLogoUrl(String logoUrl) {
            this.logoUrl = logoUrl;
        }
    }
}
