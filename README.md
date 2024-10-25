```md
# Ansible ロール: 基本セットアップ

このロールは、LVMの設定、firewalldルールの管理、ファイルディスクリプタの調整など、基本的なシステム構成を提供します。

## 必要条件

- このロールは、RedHat系ディストリビューション（例: AlmaLinux, CentOS など）をターゲットにしています。
- firewalldがインストールされており、ファイアウォールルールの設定に使用可能である必要があります。
- 論理ボリューム管理（LVM）がターゲットシステムで使用可能である必要があります。

## ロール変数

以下の変数は、`defaults/main.yml` で設定できます:

- `lvm_pvs`: LVMで使用する物理ボリュームのリスト。
- `firewalld_rules`: firewalldのリッチルールのリスト。
- `zabbix_repo_enabled`: Zabbixリポジトリをデフォルトで有効にするかどうか（デフォルトはfalse）。
- `epel_repo_enabled`: EPELリポジトリをデフォルトで有効にするかどうか（デフォルトはfalse）。

ファイルディスクリプタや基本設定に関連する変数は、`vars/main.yml` にも定義されています。

## 依存関係

このロールには他のロールへの直接的な依存関係はありませんが、EPELやZabbixなどの必要なパッケージリポジトリへのアクセスが必要です（設定に応じて）。

## 使用例

以下は、このロールを使用する際の例です。

```yaml
- hosts: servers
  roles:
    - role: ttanaka9211.ansible_role_base
      lvm_pvs:
        - /dev/sda
      firewalld_rules:
        - rule: "family=ipv4 source address=192.168.1.0/24 service name=http accept"
      zabbix_repo_enabled: true
```

この例では:
- `lvm_pvs` は、LVMで使用する物理ボリュームを定義しています。
- `firewalld_rules` は、特定のファイアウォールルールを設定しています。
- `zabbix_repo_enabled` は、Zabbixリポジトリを有効にしてパッケージをインストールします。

## ライセンス

BSD

```


