package com.cuco.syzuser.service;

import com.google.zxing.BarcodeFormat;
import com.google.zxing.EncodeHintType;
import com.google.zxing.WriterException;
import com.google.zxing.client.j2se.MatrixToImageWriter;
import com.google.zxing.common.BitMatrix;
import com.google.zxing.qrcode.QRCodeWriter;
import com.google.zxing.qrcode.decoder.ErrorCorrectionLevel;
import org.springframework.core.io.ClassPathResource;
import org.springframework.stereotype.Service;

import javax.imageio.ImageIO;
import java.awt.*;
import java.awt.geom.RoundRectangle2D;
import java.awt.image.BufferedImage;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.net.URL;
import java.util.HashMap;
import java.util.Map;

@Service
public class QrCodeService {

    private static final String LOGIN_URL = "http://localhost:5173/#/";
    private static final int DEFAULT_WIDTH = 300;
    private static final int DEFAULT_HEIGHT = 300;
    private static final int LOGO_WIDTH = 80;
    private static final int LOGO_HEIGHT = 80;

    /**
     * 生成普通二维码（返回字节数组）
     */
    public byte[] generateQrCode(String content, Integer width, Integer height) throws WriterException, IOException {
        int qrWidth = width != null ? width : DEFAULT_WIDTH;
        int qrHeight = height != null ? height : DEFAULT_HEIGHT;

        // 如果没有传入内容，默认使用登录页面URL
        String qrContent = (content == null || content.trim().isEmpty()) ? LOGIN_URL : content;

        Map<EncodeHintType, Object> hints = new HashMap<>();
        hints.put(EncodeHintType.CHARACTER_SET, "UTF-8");
        hints.put(EncodeHintType.ERROR_CORRECTION, ErrorCorrectionLevel.H);
        hints.put(EncodeHintType.MARGIN, 1);

        QRCodeWriter qrCodeWriter = new QRCodeWriter();
        BitMatrix bitMatrix = qrCodeWriter.encode(qrContent, BarcodeFormat.QR_CODE, qrWidth, qrHeight, hints);

        BufferedImage qrImage = MatrixToImageWriter.toBufferedImage(bitMatrix);

        ByteArrayOutputStream outputStream = new ByteArrayOutputStream();
        ImageIO.write(qrImage, "PNG", outputStream);
        return outputStream.toByteArray();
    }

    /**
     * 生成带Logo的二维码（返回字节数组）
     */
    public byte[] generateQrCodeWithLogo(String content, Integer width, Integer height, String logoUrl) 
            throws WriterException, IOException {
        int qrWidth = width != null ? width : DEFAULT_WIDTH;
        int qrHeight = height != null ? height : DEFAULT_HEIGHT;

        // 如果没有传入内容，默认使用登录页面URL
        String qrContent = (content == null || content.trim().isEmpty()) ? LOGIN_URL : content;

        // 设置二维码参数
        Map<EncodeHintType, Object> hints = new HashMap<>();
        hints.put(EncodeHintType.CHARACTER_SET, "UTF-8");
        hints.put(EncodeHintType.ERROR_CORRECTION, ErrorCorrectionLevel.H); // 使用高容错率
        hints.put(EncodeHintType.MARGIN, 1);

        // 生成二维码
        QRCodeWriter qrCodeWriter = new QRCodeWriter();
        BitMatrix bitMatrix = qrCodeWriter.encode(qrContent, BarcodeFormat.QR_CODE, qrWidth, qrHeight, hints);
        
        // 创建彩色二维码图像（使用TYPE_INT_RGB支持彩色）
        BufferedImage qrImage = new BufferedImage(qrWidth, qrHeight, BufferedImage.TYPE_INT_RGB);
        Graphics2D qrG2d = qrImage.createGraphics();
        qrG2d.setColor(Color.WHITE);
        qrG2d.fillRect(0, 0, qrWidth, qrHeight);
        qrG2d.setColor(Color.BLACK);
        
        // 绘制二维码
        for (int x = 0; x < qrWidth; x++) {
            for (int y = 0; y < qrHeight; y++) {
                if (bitMatrix.get(x, y)) {
                    qrG2d.fillRect(x, y, 1, 1);
                }
            }
        }
        qrG2d.dispose();

        // 加载Logo图片
        BufferedImage logoImage = loadLogoImage(logoUrl);
        
        // 将Logo嵌入到二维码中
        BufferedImage combinedImage = insertLogoImage(qrImage, logoImage, qrWidth, qrHeight);

        // 转换为字节数组
        ByteArrayOutputStream outputStream = new ByteArrayOutputStream();
        ImageIO.write(combinedImage, "PNG", outputStream);
        return outputStream.toByteArray();
    }

    /**
     * 加载Logo图片
     * 支持三种方式：
     * 1. 本地文件路径（如：logo.png）- 从 resources/static/logos/ 目录加载
     * 2. HTTP/HTTPS URL（如：https://example.com/logo.png）
     * 3. 空值 - 使用默认Logo
     */
    private BufferedImage loadLogoImage(String logoUrl) throws IOException {
        BufferedImage logoImage;
        
        if (logoUrl != null && !logoUrl.trim().isEmpty()) {
            try {
                BufferedImage originalImage = null;
                
                // 判断是URL还是本地文件名
                if (logoUrl.startsWith("http://") || logoUrl.startsWith("https://")) {
                    // 从URL加载
                    URL url = new URL(logoUrl);
                    originalImage = ImageIO.read(url);
                } else {
                    // 从本地资源加载（resources/static/logos/目录）
                    ClassPathResource resource = new ClassPathResource("static/logos/" + logoUrl);
                    if (resource.exists()) {
                        InputStream inputStream = resource.getInputStream();
                        originalImage = ImageIO.read(inputStream);
                        inputStream.close();
                    } else {
                        // 如果文件不存在，使用默认Logo
                        System.out.println("Logo文件不存在: " + logoUrl + "，使用默认Logo");
                        return createDefaultLogo();
                    }
                }
                
                // 确保图像是彩色模式（ARGB）
                if (originalImage != null) {
                    // 创建一个新的ARGB图像，确保支持彩色和透明度
                    BufferedImage argbImage = new BufferedImage(
                        originalImage.getWidth(), 
                        originalImage.getHeight(), 
                        BufferedImage.TYPE_INT_ARGB
                    );
                    Graphics2D g = argbImage.createGraphics();
                    g.drawImage(originalImage, 0, 0, null);
                    g.dispose();
                    logoImage = argbImage;
                } else {
                    logoImage = createDefaultLogo();
                }
            } catch (Exception e) {
                // 如果加载失败，使用默认Logo
                System.out.println("Logo加载失败: " + e.getMessage() + "，使用默认Logo");
                logoImage = createDefaultLogo();
            }
        } else {
            // 使用默认Logo
            logoImage = createDefaultLogo();
        }
        
        return logoImage;
    }

    /**
     * 创建默认Logo（一个简单的蓝色圆形）
     */
    private BufferedImage createDefaultLogo() {
        BufferedImage logo = new BufferedImage(LOGO_WIDTH, LOGO_HEIGHT, BufferedImage.TYPE_INT_ARGB);
        Graphics2D g2d = logo.createGraphics();
        
        // 抗锯齿
        g2d.setRenderingHint(RenderingHints.KEY_ANTIALIASING, RenderingHints.VALUE_ANTIALIAS_ON);
        
        // 绘制白色背景圆形
        g2d.setColor(Color.WHITE);
        g2d.fillOval(0, 0, LOGO_WIDTH, LOGO_HEIGHT);
        
        // 绘制蓝色圆形
        g2d.setColor(new Color(74, 144, 226)); // #4A90E2
        g2d.fillOval(5, 5, LOGO_WIDTH - 10, LOGO_HEIGHT - 10);
        
        g2d.dispose();
        return logo;
    }

    /**
     * 将Logo插入到二维码中心（保留原始颜色）
     */
    private BufferedImage insertLogoImage(BufferedImage qrImage, BufferedImage logoImage, 
                                          int qrWidth, int qrHeight) {
        Graphics2D g2d = qrImage.createGraphics();
        
        // 设置最高质量渲染
        g2d.setRenderingHint(RenderingHints.KEY_ANTIALIASING, RenderingHints.VALUE_ANTIALIAS_ON);
        g2d.setRenderingHint(RenderingHints.KEY_RENDERING, RenderingHints.VALUE_RENDER_QUALITY);
        g2d.setRenderingHint(RenderingHints.KEY_INTERPOLATION, RenderingHints.VALUE_INTERPOLATION_BILINEAR);
        g2d.setRenderingHint(RenderingHints.KEY_COLOR_RENDERING, RenderingHints.VALUE_COLOR_RENDER_QUALITY);
        g2d.setRenderingHint(RenderingHints.KEY_ALPHA_INTERPOLATION, RenderingHints.VALUE_ALPHA_INTERPOLATION_QUALITY);
        g2d.setRenderingHint(RenderingHints.KEY_TEXT_ANTIALIASING, RenderingHints.VALUE_TEXT_ANTIALIAS_ON);
        
        // 计算Logo位置（居中）
        int logoX = (qrWidth - LOGO_WIDTH) / 2;
        int logoY = (qrHeight - LOGO_HEIGHT) / 2;
        
        // 绘制白色圆角矩形背景（增加边距）
        int padding = 8;
        g2d.setColor(Color.WHITE);
        RoundRectangle2D.Float roundRect = new RoundRectangle2D.Float(
            logoX - padding, logoY - padding, 
            LOGO_WIDTH + padding * 2, LOGO_HEIGHT + padding * 2, 
            20, 20
        );
        g2d.fill(roundRect);
        
        // 使用更高质量的缩放算法
        Image scaledImage = logoImage.getScaledInstance(LOGO_WIDTH, LOGO_HEIGHT, Image.SCALE_SMOOTH);
        
        // 创建高质量的缩放后图像
        BufferedImage scaledLogo = new BufferedImage(LOGO_WIDTH, LOGO_HEIGHT, BufferedImage.TYPE_INT_ARGB);
        Graphics2D logoG2d = scaledLogo.createGraphics();
        
        // 设置最高质量缩放
        logoG2d.setRenderingHint(RenderingHints.KEY_INTERPOLATION, RenderingHints.VALUE_INTERPOLATION_BILINEAR);
        logoG2d.setRenderingHint(RenderingHints.KEY_RENDERING, RenderingHints.VALUE_RENDER_QUALITY);
        logoG2d.setRenderingHint(RenderingHints.KEY_ANTIALIASING, RenderingHints.VALUE_ANTIALIAS_ON);
        logoG2d.setRenderingHint(RenderingHints.KEY_COLOR_RENDERING, RenderingHints.VALUE_COLOR_RENDER_QUALITY);
        logoG2d.setRenderingHint(RenderingHints.KEY_ALPHA_INTERPOLATION, RenderingHints.VALUE_ALPHA_INTERPOLATION_QUALITY);
        
        // 绘制缩放后的Logo（保留颜色）
        logoG2d.drawImage(scaledImage, 0, 0, null);
        logoG2d.dispose();
        
        // 将缩放后的Logo绘制到二维码上
        g2d.drawImage(scaledLogo, logoX, logoY, null);
        
        g2d.dispose();
        return qrImage;
    }

    /**
     * 生成登录页面二维码（快捷方法）
     */
    public byte[] generateLoginQrCode(boolean withLogo) throws WriterException, IOException {
        if (withLogo) {
            return generateQrCodeWithLogo(LOGIN_URL, null, null, null);
        } else {
            return generateQrCode(LOGIN_URL, null, null);
        }
    }
}
