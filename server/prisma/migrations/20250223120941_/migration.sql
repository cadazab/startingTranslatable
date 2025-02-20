-- CreateTable
CREATE TABLE "Language" (
    "id" TEXT NOT NULL,
    "code" TEXT NOT NULL,
    "name" TEXT NOT NULL,

    CONSTRAINT "Language_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Locale" (
    "id" TEXT NOT NULL,
    "code" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "languageId" TEXT NOT NULL,

    CONSTRAINT "Locale_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "User" (
    "id" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "avatarUrl" TEXT NOT NULL,
    "role" TEXT NOT NULL,
    "organizationID" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "User_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Organization" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "activeLocales" TEXT NOT NULL,

    CONSTRAINT "Organization_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "CustomLocale" (
    "id" TEXT NOT NULL,
    "code" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "languageId" TEXT NOT NULL,
    "organizationID" TEXT NOT NULL,

    CONSTRAINT "CustomLocale_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Translation" (
    "id" TEXT NOT NULL,
    "code" TEXT NOT NULL,
    "organizationID" TEXT NOT NULL,
    "localeType" TEXT NOT NULL,
    "localeId" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Translation_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Translator" (
    "id" TEXT NOT NULL,
    "userId" TEXT NOT NULL,
    "organizationID" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Translator_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "translatorsAuthorizedLocales" (
    "id" TEXT NOT NULL,
    "translatorId" TEXT NOT NULL,
    "organizationID" TEXT NOT NULL,
    "localeId" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "translatorsAuthorizedLocales_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Test" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Test_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "_OrganizationToTranslator" (
    "A" TEXT NOT NULL,
    "B" TEXT NOT NULL,

    CONSTRAINT "_OrganizationToTranslator_AB_pkey" PRIMARY KEY ("A","B")
);

-- CreateIndex
CREATE UNIQUE INDEX "Language_code_key" ON "Language"("code");

-- CreateIndex
CREATE UNIQUE INDEX "Language_name_key" ON "Language"("name");

-- CreateIndex
CREATE UNIQUE INDEX "Locale_code_key" ON "Locale"("code");

-- CreateIndex
CREATE UNIQUE INDEX "Locale_name_key" ON "Locale"("name");

-- CreateIndex
CREATE UNIQUE INDEX "User_email_key" ON "User"("email");

-- CreateIndex
CREATE UNIQUE INDEX "CustomLocale_code_name_organizationID_key" ON "CustomLocale"("code", "name", "organizationID");

-- CreateIndex
CREATE UNIQUE INDEX "Translation_code_organizationID_localeId_key" ON "Translation"("code", "organizationID", "localeId");

-- CreateIndex
CREATE UNIQUE INDEX "Translator_userId_key" ON "Translator"("userId");

-- CreateIndex
CREATE UNIQUE INDEX "Translator_userId_organizationID_key" ON "Translator"("userId", "organizationID");

-- CreateIndex
CREATE UNIQUE INDEX "translatorsAuthorizedLocales_translatorId_organizationID_lo_key" ON "translatorsAuthorizedLocales"("translatorId", "organizationID", "localeId");

-- CreateIndex
CREATE INDEX "_OrganizationToTranslator_B_index" ON "_OrganizationToTranslator"("B");

-- AddForeignKey
ALTER TABLE "Locale" ADD CONSTRAINT "Locale_languageId_fkey" FOREIGN KEY ("languageId") REFERENCES "Language"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "User" ADD CONSTRAINT "User_organizationID_fkey" FOREIGN KEY ("organizationID") REFERENCES "Organization"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CustomLocale" ADD CONSTRAINT "CustomLocale_languageId_fkey" FOREIGN KEY ("languageId") REFERENCES "Language"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CustomLocale" ADD CONSTRAINT "CustomLocale_organizationID_fkey" FOREIGN KEY ("organizationID") REFERENCES "Organization"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Translation" ADD CONSTRAINT "Translation_organizationID_fkey" FOREIGN KEY ("organizationID") REFERENCES "Organization"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Translator" ADD CONSTRAINT "Translator_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "translatorsAuthorizedLocales" ADD CONSTRAINT "translatorsAuthorizedLocales_translatorId_fkey" FOREIGN KEY ("translatorId") REFERENCES "Translator"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "translatorsAuthorizedLocales" ADD CONSTRAINT "translatorsAuthorizedLocales_organizationID_fkey" FOREIGN KEY ("organizationID") REFERENCES "Organization"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "translatorsAuthorizedLocales" ADD CONSTRAINT "translatorsAuthorizedLocales_localeId_fkey" FOREIGN KEY ("localeId") REFERENCES "Locale"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_OrganizationToTranslator" ADD CONSTRAINT "_OrganizationToTranslator_A_fkey" FOREIGN KEY ("A") REFERENCES "Organization"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_OrganizationToTranslator" ADD CONSTRAINT "_OrganizationToTranslator_B_fkey" FOREIGN KEY ("B") REFERENCES "Translator"("id") ON DELETE CASCADE ON UPDATE CASCADE;
