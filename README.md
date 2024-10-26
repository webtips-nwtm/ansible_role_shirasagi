# webtips-nwtm/ansible_role_shirasagi

以下は、https://github.com/webtips-nwtm/ansible_role_shirasagi 用の日本語版 README.md のテンプレートです。

# Ansible Role: Shirasagi

[![CI](https://github.com/webtips-nwtm/ansible_role_shirasagi/actions/workflows/ci.yml/badge.svg)](https://github.com/webtips-nwtm/ansible_role_shirasagi/actions/workflows/ci.yml)

このAnsibleロールは、Ruby on Railsで構築されたコンテンツ管理システム（CMS）である [Shirasagi](https://shirasagi.github.io/) をインストールおよび設定します。

## 必要条件

- Ansible 2.9以上
- 対象OS: AlmaLinux 9、その他Red Hat系ディストリビューション
- [asdf](https://asdf-vm.com/) またはシステム全体のRuby環境
- MongoDBのインストールと稼働
- ImageMagickおよびその他の依存パッケージ（依存関係参照）

## 変数

以下は、カスタマイズ可能な変数の例です。プレイブックや `vars/main.yml` で設定可能です。

```yaml
shirasagi_repo: "https://github.com/shirasagi/shirasagi.git" # ShirasagiのGitリポジトリURL
shirasagi_branch: "master" # 使用するブランチ
ruby_version: "3.0.1" # asdfまたはシステム全体でのRubyバージョン
mongodb_version: "4.4" # MongoDBのバージョン
```

プレイブックの例

```yaml
- hosts: servers
  become: yes
  roles:
    - role: webtips-nwtm.ansible_role_shirasagi
      vars:
        shirasagi_branch: "stable"
        ruby_version: "3.0.1"
        mongodb_version: "4.4"
```

ハンドラー

このロールには、以下のサービスを管理するためのハンドラーが含まれています

    •	Restart unicorn.service
    •	Restart shirasagi-job.service
    •	Reload firewalld
