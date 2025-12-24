package com.cuco.syzuser.service;

import com.aliyun.dysmsapi20170525.Client;
import com.aliyun.dysmsapi20170525.models.SendSmsRequest;
import com.aliyun.dysmsapi20170525.models.SendSmsResponse;
import com.aliyun.teaopenapi.models.Config;
import com.google.gson.Gson;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.stereotype.Service;

import java.util.Map;
import java.util.Random;
import java.util.concurrent.TimeUnit;

@Service
public class SmsService {

    @Autowired
    private StringRedisTemplate redisTemplate;

    @Value("${aliyun.sms.access-key-id}")
    private String accessKeyId;

    @Value("${aliyun.sms.access-key-secret}")
    private String accessKeySecret;

    @Value("${aliyun.sms.sign-name}")
    private String signName;

    @Value("${aliyun.sms.template-code}")
    private String templateCode;

    @Value("${aliyun.sms.endpoint}")
    private String endpoint;

    public boolean sendVerifyCode(String phone) {
        String code = String.valueOf(new Random().nextInt(899999) + 100000);

        try {
            // 配置阿里云SDK
            Config config = new Config()
                    .setAccessKeyId(accessKeyId)
                    .setAccessKeySecret(accessKeySecret)
                    .setEndpoint(endpoint);

            // 创建短信客户端
            Client client = new Client(config);

            // 构建短信参数
            String templateParam = new Gson().toJson(Map.of("code", code));

            SendSmsRequest sendSmsRequest = new SendSmsRequest()
                    .setSignName(signName)
                    .setTemplateCode(templateCode)
                    .setPhoneNumbers(phone)
                    .setTemplateParam(templateParam);

            // 发送短信
            SendSmsResponse response = client.sendSms(sendSmsRequest);

            if ("OK".equals(response.getBody().getCode())) {
                System.out.println("发送成功: " + code);
                redisTemplate.opsForValue().set("sms:login:" + phone, code, 300, TimeUnit.SECONDS);
                return true;
            } else {
                System.err.println("发送失败: " + response.getBody().getMessage());
                return false;
            }
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean validateCode(String phone, String inputCode) {
        if (inputCode == null || inputCode.isEmpty()) return false;
        String redisKey = "sms:login:" + phone;
        String correctCode = redisTemplate.opsForValue().get(redisKey);
        if (correctCode != null && correctCode.equals(inputCode)) {
            redisTemplate.delete(redisKey);
            return true;
        }
        return false;
    }
}