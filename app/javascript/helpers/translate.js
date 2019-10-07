export default function translate(resource, currentLang) {
  let translation =  resource.translations.find((translation) => {
    return translation.language.iso == currentLang
  })
  if (translation.status == "completed") {
    return translation.content
  } else {
    return `Translation status: ${translation.status}`
  }
}
