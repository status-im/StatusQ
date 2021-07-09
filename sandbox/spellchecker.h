#ifndef SPELLCHECKER_H
#define SPELLCHECKER_H

#include <QObject>
#include <QVariant>
#include <QQuickTextDocument>
#include <QSyntaxHighlighter>

class Hunspell;
class QTextCodec;

class SpellChecker : public QSyntaxHighlighter
{
    Q_OBJECT
    Q_PROPERTY(QString text READ text WRITE setText NOTIFY textChanged)
    Q_PROPERTY(QString displayText READ displayText NOTIFY displayTextChanged)
    Q_PROPERTY(QQuickTextDocument* document READ textDocument WRITE setTextDocument NOTIFY textDocumentChanged)
public:
    explicit SpellChecker(QObject *parent = nullptr);
    ~SpellChecker();

    Q_INVOKABLE bool spell(const QString& word);
    Q_INVOKABLE QVariantList suggest(const QString &word);
    Q_INVOKABLE void ignoreWord(const QString &word);
    Q_INVOKABLE void addToUserWordlist(const QString &word);

    void setText(const QString& text);
    const QString& text() const;

    const QString& displayText() const;

    QQuickTextDocument* textDocument() const;
    void setTextDocument(QQuickTextDocument* document);

signals:
    void textChanged();
    void displayTextChanged();
    void textDocumentChanged();

protected:
    void highlightBlock(const QString &text) final;

private:
    void makeDisplayText(const QString& text);

private:
    QString m_text;
    QString m_displayText;
    QString m_dictionaryPath;

    QQuickTextDocument *m_document;

    Hunspell *m_hunspell;
    QTextCodec *m_codec;
};

#endif // SPELLCHECKER_H
