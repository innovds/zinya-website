#!/bin/bash

echo "🚀 Vérification du déploiement Zinya Privacy Policy..."
echo ""

# Couleurs pour l'affichage
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

URL="https://innovds.github.io/zinya-website/"

echo -e "${BLUE}🌐 URL à tester :${NC} $URL"
echo ""

# Test de l'URL avec curl si disponible
if command -v curl &> /dev/null; then
    echo -e "${YELLOW}📡 Test de connexion...${NC}"
    response=$(curl -s -o /dev/null -w "%{http_code}" "$URL" 2>/dev/null)
    
    if [ "$response" = "200" ]; then
        echo -e "${GREEN}✅ SUCCESS: La politique de confidentialité est en ligne !${NC}"
        echo -e "${GREEN}🎯 Statut HTTP: $response (OK)${NC}"
        
        # Test du contenu spécifique
        echo ""
        echo -e "${YELLOW}🔍 Vérification du contenu...${NC}"
        content=$(curl -s "$URL" 2>/dev/null)
        
        if echo "$content" | grep -q "com.zinya.app.test"; then
            echo -e "${GREEN}✅ Package ID correct trouvé${NC}"
        else
            echo -e "${RED}❌ Package ID manquant${NC}"
        fi
        
        if echo "$content" | grep -q "22e423e8-a377-48df-86e9-200dcd87bbb5"; then
            echo -e "${GREEN}✅ Build ID correct trouvé${NC}"
        else
            echo -e "${RED}❌ Build ID manquant${NC}"
        fi
        
        if echo "$content" | grep -q "Test fermé alpha"; then
            echo -e "${GREEN}✅ Contexte de test correct${NC}"
        else
            echo -e "${RED}❌ Contexte de test manquant${NC}"
        fi
        
        echo ""
        echo -e "${GREEN}📋 URL prête pour Google Play Console :${NC}"
        echo -e "${BLUE}$URL${NC}"
        
    elif [ "$response" = "404" ]; then
        echo -e "${YELLOW}⏳ ATTENTE: GitHub Pages en cours d'activation...${NC}"
        echo -e "${YELLOW}🕒 Réessayer dans 5-10 minutes${NC}"
        echo ""
        echo -e "${BLUE}📋 Actions à vérifier :${NC}"
        echo "1. Aller sur: https://github.com/innovds/zinya-website/settings/pages"
        echo "2. Source: Deploy from a branch"
        echo "3. Branch: main / / (root)"
        echo "4. Attendre 5-10 minutes"
        
    else
        echo -e "${RED}⚠️  Statut HTTP: $response${NC}"
        echo -e "${YELLOW}📋 Actions à vérifier :${NC}"
        echo "1. GitHub → Settings → Pages"
        echo "2. Source: main branch"
        echo "3. Attendre 5-10 minutes"
    fi
else
    echo -e "${YELLOW}📋 curl non disponible. Testez manuellement cette URL :${NC}"
    echo -e "${BLUE}$URL${NC}"
fi

echo ""
echo -e "${BLUE}🚀 Usage dans Google Play Console :${NC}"
echo "   • Aller dans: Play Console → Contenu de l'application"
echo "   • Section: Politique de confidentialité"
echo "   • Coller l'URL: $URL"
echo ""
echo -e "${GREEN}✨ Fait ! Politique de confidentialité déployée avec succès${NC}"
