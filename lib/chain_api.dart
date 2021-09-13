library chain_api;
import 'package:bip39/bip39.dart' as bip39;
import 'package:dart_bip32_bip44/dart_bip32_bip44.dart';
import 'package:web3dart/web3dart.dart';

/// A Calculator.
class Calculator {
  /// Returns [value] plus 1.
  int addOne(int value) => value + 1;

  Future<String> getKey() async{
    //随机生成助记词
    var randomMnemonic = bip39.generateMnemonic();
    print("生成助记词:$randomMnemonic");
    randomMnemonic = "chimney refuse inspire language subway horror middle tube property knife garage exclude";
    print("测试组基础生成私钥地址正确性，对比网址：https://iancoleman.io/bip39/#english");
    var seed = bip39.mnemonicToSeedHex(randomMnemonic);

    //种子生成私钥地址
    Chain chain = Chain.seed(seed);
    ExtendedKey key = chain.forPath("m/44'/60'/0'/0/0");
    var privateKey = key.privateKeyHex();
    print("生成私钥:$privateKey");
    Credentials credentials = EthPrivateKey.fromHex(privateKey);
    var address = await credentials.extractAddress();
    print("生成地址:$address");

    return privateKey;
  }

}
