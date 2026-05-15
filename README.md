# EventGallery Pro - Multi-Vendor Event Decorator Portfolio SaaS

A premium, luxury-focused SaaS platform for event decorators to showcase their work, manage bookings, and grow their business.

## 🎨 Features

### Super Admin Dashboard
- Secure admin authentication
- Manage decorator accounts (create, delete, activate/deactivate)
- View analytics (decorators, bookings, enquiries, revenue)
- Manage subscription plans
- Control platform branding (logo, banners)
- User management
- Gallery image management

### Decorator Dashboard
- Personal account management
- Gallery upload & management
- Service management
- Pricing package management
- Booking management
- Enquiry tracking
- Profile customization
- Social media integration

### Public Portfolio Website
- Beautiful home page with featured work
- Gallery with category filtering
- Pricing packages display
- About page
- Testimonials section
- Contact & booking form
- WhatsApp integration
- SEO optimized

## 🛠 Tech Stack

**Frontend:** React.js + Tailwind CSS
**Backend:** Node.js + Express.js
**Database:** Supabase (PostgreSQL)
**Auth:** Supabase Auth
**Storage:** Cloudinary
**Hosting:** Vercel
**Version Control:** GitHub

## 📁 Project Structure

```
eventgallery-pro/
├── frontend/                 # React frontend
│   ├── src/
│   │   ├── components/      # Reusable components
│   │   ├── pages/           # Page components
│   │   ├── dashboards/      # Admin & Decorator dashboards
│   │   ├── hooks/           # Custom React hooks
│   │   ├── context/         # Context API
│   │   ├── services/        # API services
│   │   ├── styles/          # Global styles
│   │   └── App.jsx
│   ├── public/
│   ├── package.json
│   └── vite.config.js
├── backend/                  # Node.js + Express backend
│   ├── src/
│   │   ├── routes/          # API routes
│   │   ├── controllers/      # Route controllers
│   │   ├── middleware/       # Custom middleware
│   │   ├── models/          # Database models
│   │   ├── config/          # Configuration
│   │   └── index.js
│   ├── .env.example
│   └── package.json
├── database/                 # Database schema & migrations
│   └── schema.sql
└── docs/                     # Documentation
    └── DEPLOYMENT.md
```

## 🚀 Quick Start

### Prerequisites
- Node.js 16+
- npm or yarn
- Supabase account (free)
- Cloudinary account (free)
- GitHub account

### Installation

1. **Clone Repository**
```bash
git clone <your-repo>
cd eventgallery-pro
```

2. **Setup Backend**
```bash
cd backend
npm install
cp .env.example .env
# Update .env with your credentials
npm run dev
```

3. **Setup Frontend**
```bash
cd ../frontend
npm install
cp .env.example .env
# Update .env with API URL
npm run dev
```

4. **Setup Database**
- Create Supabase project
- Run schema.sql in Supabase SQL editor
- Enable Row Level Security
- Set up authentication

## 🔐 Environment Variables

### Backend (.env)
```
NODE_ENV=development
PORT=5000
SUPABASE_URL=your_supabase_url
SUPABASE_ANON_KEY=your_anon_key
SUPABASE_SERVICE_KEY=your_service_key
JWT_SECRET=your_jwt_secret
CLOUDINARY_NAME=your_cloudinary_name
CLOUDINARY_API_KEY=your_api_key
CLOUDINARY_API_SECRET=your_api_secret
SMTP_FROM=noreply@eventgallery.pro
SMTP_HOST=your_smtp_host
SMTP_PORT=587
SMTP_USER=your_email
SMTP_PASS=your_password
```

### Frontend (.env)
```
VITE_API_URL=http://localhost:5000
VITE_SUPABASE_URL=your_supabase_url
VITE_SUPABASE_ANON_KEY=your_anon_key
VITE_CLOUDINARY_UPLOAD_PRESET=your_upload_preset
```

## 📊 Database Schema

Key tables:
- `decorators` - Decorator accounts
- `gallery` - Uploaded images
- `packages` - Pricing packages
- `bookings` - Booking requests
- `enquiries` - Customer enquiries
- `testimonials` - Customer reviews
- `platform_settings` - Admin settings
- `subscription_plans` - Available plans

## 🔑 Default Admin Credentials

**Email:** admin@eventgallery.pro
**Password:** Admin@123456

⚠️ Change these immediately after first login!

## 📚 API Endpoints

### Authentication
- `POST /api/auth/register` - Register new decorator
- `POST /api/auth/login` - Login
- `POST /api/auth/logout` - Logout
- `GET /api/auth/me` - Get current user

### Decorators
- `GET /api/decorators` - List all decorators
- `POST /api/decorators` - Create decorator
- `GET /api/decorators/:id` - Get decorator details
- `PUT /api/decorators/:id` - Update decorator
- `DELETE /api/decorators/:id` - Delete decorator

### Gallery
- `GET /api/gallery/:decoratorId` - Get gallery images
- `POST /api/gallery/upload` - Upload image
- `DELETE /api/gallery/:id` - Delete image

### Bookings
- `GET /api/bookings/:decoratorId` - Get bookings
- `POST /api/bookings` - Create booking
- `PUT /api/bookings/:id` - Update booking status

### Packages
- `GET /api/packages/:decoratorId` - Get packages
- `POST /api/packages` - Create package
- `PUT /api/packages/:id` - Update package
- `DELETE /api/packages/:id` - Delete package

## 🎨 Design System

- **Primary Color:** #1a1a1a (Luxury Black)
- **Accent Color:** #d4af37 (Gold)
- **Secondary:** #f5f5f5 (Light Gray)
- **Font:** Plus Jakarta Sans, Playfair Display

## 📱 Responsive Design

- Mobile-first approach
- Breakpoints: 320px, 640px, 1024px, 1280px
- Touch-friendly interface
- Fast loading times

## 🔒 Security Features

- JWT authentication
- Supabase Row Level Security
- Password hashing (bcryptjs)
- CORS protection
- Rate limiting
- Input validation
- SQL injection prevention

## 📧 Email Notifications

- Welcome email on signup
- Booking confirmation
- New enquiry notification
- Admin alerts

## 🚢 Deployment

### Frontend (Vercel)
```bash
npm run build
vercel deploy
```

### Backend (Vercel Functions / Railway / Render)
```bash
# See DEPLOYMENT.md for detailed instructions
```

## 📈 Scaling Considerations

- Supabase auto-scales with load
- Cloudinary handles image optimization
- Vercel provides edge caching
- Database indexing for performance
- Image compression & lazy loading

## 🐛 Testing

```bash
# Backend tests
cd backend
npm run test

# Frontend tests
cd ../frontend
npm run test
```

## 📞 Support

For issues and questions, please refer to documentation or contact support.

## 📄 License

Proprietary - EventGallery Pro Inc.

---

**Built with ❤️ for event decorators worldwide**