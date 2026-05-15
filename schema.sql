-- EventGallery Pro - Supabase Schema
-- Run this in Supabase SQL Editor

-- Enable Extensions
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";
CREATE EXTENSION IF NOT EXISTS "pgtap";

-- Decorators Table
CREATE TABLE decorators (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  email VARCHAR(255) UNIQUE NOT NULL,
  password VARCHAR(255) NOT NULL,
  business_name VARCHAR(255) NOT NULL,
  first_name VARCHAR(100),
  last_name VARCHAR(100),
  city VARCHAR(100),
  state VARCHAR(100),
  country VARCHAR(100),
  phone VARCHAR(20) NOT NULL,
  whatsapp_number VARCHAR(20),
  instagram_url VARCHAR(255),
  youtube_url VARCHAR(255),
  website_url VARCHAR(255),
  about_us TEXT,
  logo_url VARCHAR(255),
  banner_url VARCHAR(255),
  specialization VARCHAR(255),
  experience_years INTEGER,
  active_status BOOLEAN DEFAULT false,
  verified BOOLEAN DEFAULT false,
  subscription_plan VARCHAR(50) DEFAULT 'free',
  subscription_expires_at TIMESTAMP,
  total_bookings INTEGER DEFAULT 0,
  total_revenue DECIMAL(10, 2) DEFAULT 0,
  average_rating DECIMAL(2, 1) DEFAULT 0,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  deleted_at TIMESTAMP
);

-- Gallery Table
CREATE TABLE gallery (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  decorator_id UUID NOT NULL REFERENCES decorators(id) ON DELETE CASCADE,
  image_url VARCHAR(500) NOT NULL,
  cloudinary_public_id VARCHAR(255),
  category VARCHAR(50) NOT NULL,
  title VARCHAR(200),
  description TEXT,
  is_featured BOOLEAN DEFAULT false,
  display_order INTEGER,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Packages Table
CREATE TABLE packages (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  decorator_id UUID NOT NULL REFERENCES decorators(id) ON DELETE CASCADE,
  package_name VARCHAR(100) NOT NULL,
  package_tier VARCHAR(50) NOT NULL,
  package_price DECIMAL(10, 2) NOT NULL,
  package_details TEXT,
  deliverables TEXT,
  service_type VARCHAR(100),
  duration_hours INTEGER,
  is_active BOOLEAN DEFAULT true,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Bookings Table
CREATE TABLE bookings (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  decorator_id UUID NOT NULL REFERENCES decorators(id) ON DELETE CASCADE,
  customer_name VARCHAR(255) NOT NULL,
  customer_email VARCHAR(255),
  customer_phone VARCHAR(20) NOT NULL,
  event_date DATE NOT NULL,
  event_time TIME,
  event_type VARCHAR(100) NOT NULL,
  event_location VARCHAR(500),
  budget DECIMAL(10, 2),
  guest_count INTEGER,
  special_requirements TEXT,
  message TEXT,
  booking_status VARCHAR(50) DEFAULT 'pending',
  assigned_package_id UUID REFERENCES packages(id),
  payment_status VARCHAR(50) DEFAULT 'unpaid',
  payment_method VARCHAR(50),
  amount_paid DECIMAL(10, 2),
  notes TEXT,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  scheduled_date TIMESTAMP,
  completed_date TIMESTAMP
);

-- Enquiries Table
CREATE TABLE enquiries (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  decorator_id UUID NOT NULL REFERENCES decorators(id) ON DELETE CASCADE,
  customer_name VARCHAR(255) NOT NULL,
  customer_email VARCHAR(255) NOT NULL,
  customer_phone VARCHAR(20),
  event_type VARCHAR(100),
  event_date DATE,
  budget_range VARCHAR(50),
  message TEXT NOT NULL,
  enquiry_status VARCHAR(50) DEFAULT 'new',
  assigned_to UUID REFERENCES decorators(id),
  read_at TIMESTAMP,
  replied_at TIMESTAMP,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Testimonials Table
CREATE TABLE testimonials (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  decorator_id UUID NOT NULL REFERENCES decorators(id) ON DELETE CASCADE,
  booking_id UUID REFERENCES bookings(id),
  customer_name VARCHAR(255) NOT NULL,
  customer_email VARCHAR(255),
  review TEXT NOT NULL,
  rating DECIMAL(2, 1) NOT NULL CHECK (rating >= 1 AND rating <= 5),
  is_verified BOOLEAN DEFAULT false,
  is_featured BOOLEAN DEFAULT false,
  approved BOOLEAN DEFAULT false,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Admin Table
CREATE TABLE admins (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  email VARCHAR(255) UNIQUE NOT NULL,
  password VARCHAR(255) NOT NULL,
  first_name VARCHAR(100),
  last_name VARCHAR(100),
  role VARCHAR(50) DEFAULT 'admin',
  permissions TEXT[],
  is_active BOOLEAN DEFAULT true,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  last_login TIMESTAMP
);

-- Platform Settings Table
CREATE TABLE platform_settings (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  setting_key VARCHAR(100) UNIQUE NOT NULL,
  setting_value TEXT,
  description TEXT,
  updated_by UUID REFERENCES admins(id),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Subscription Plans Table
CREATE TABLE subscription_plans (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  plan_name VARCHAR(100) NOT NULL,
  plan_slug VARCHAR(100) UNIQUE NOT NULL,
  monthly_price DECIMAL(10, 2),
  yearly_price DECIMAL(10, 2),
  features JSONB,
  gallery_limit INTEGER,
  package_limit INTEGER,
  is_active BOOLEAN DEFAULT true,
  description TEXT,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Payments Table
CREATE TABLE payments (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  decorator_id UUID REFERENCES decorators(id) ON DELETE CASCADE,
  booking_id UUID REFERENCES bookings(id) ON DELETE CASCADE,
  amount DECIMAL(10, 2) NOT NULL,
  payment_method VARCHAR(50) NOT NULL,
  payment_status VARCHAR(50) DEFAULT 'pending',
  transaction_id VARCHAR(255),
  stripe_payment_intent_id VARCHAR(255),
  razorpay_payment_id VARCHAR(255),
  refund_amount DECIMAL(10, 2),
  refund_status VARCHAR(50),
  notes TEXT,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Activity Logs Table
CREATE TABLE activity_logs (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  user_id UUID,
  user_type VARCHAR(50),
  action VARCHAR(100) NOT NULL,
  resource_type VARCHAR(100),
  resource_id UUID,
  changes JSONB,
  ip_address VARCHAR(50),
  user_agent TEXT,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create Indexes for Performance
CREATE INDEX idx_decorators_email ON decorators(email);
CREATE INDEX idx_decorators_active ON decorators(active_status);
CREATE INDEX idx_decorators_created ON decorators(created_at DESC);
CREATE INDEX idx_gallery_decorator ON gallery(decorator_id);
CREATE INDEX idx_gallery_category ON gallery(category);
CREATE INDEX idx_packages_decorator ON packages(decorator_id);
CREATE INDEX idx_bookings_decorator ON bookings(decorator_id);
CREATE INDEX idx_bookings_status ON bookings(booking_status);
CREATE INDEX idx_bookings_date ON bookings(event_date);
CREATE INDEX idx_enquiries_decorator ON enquiries(decorator_id);
CREATE INDEX idx_enquiries_status ON enquiries(enquiry_status);
CREATE INDEX idx_testimonials_decorator ON testimonials(decorator_id);
CREATE INDEX idx_testimonials_rating ON testimonials(rating DESC);
CREATE INDEX idx_payments_decorator ON payments(decorator_id);
CREATE INDEX idx_activity_logs_user ON activity_logs(user_id);
CREATE INDEX idx_activity_logs_created ON activity_logs(created_at DESC);

-- Enable Row Level Security
ALTER TABLE decorators ENABLE ROW LEVEL SECURITY;
ALTER TABLE gallery ENABLE ROW LEVEL SECURITY;
ALTER TABLE packages ENABLE ROW LEVEL SECURITY;
ALTER TABLE bookings ENABLE ROW LEVEL SECURITY;
ALTER TABLE enquiries ENABLE ROW LEVEL SECURITY;
ALTER TABLE testimonials ENABLE ROW LEVEL SECURITY;
ALTER TABLE admins ENABLE ROW LEVEL SECURITY;
ALTER TABLE payments ENABLE ROW LEVEL SECURITY;

-- RLS Policies
-- Decorators can view/update their own profile
CREATE POLICY "Decorators can view own profile" 
  ON decorators FOR SELECT 
  USING (auth.uid() = id);

CREATE POLICY "Decorators can update own profile" 
  ON decorators FOR UPDATE 
  USING (auth.uid() = id);

-- Gallery policies
CREATE POLICY "Anyone can view public galleries" 
  ON gallery FOR SELECT 
  USING (true);

CREATE POLICY "Decorators can manage own gallery" 
  ON gallery FOR ALL 
  USING (decorator_id = auth.uid());

-- Bookings policies
CREATE POLICY "Decorators can view own bookings" 
  ON bookings FOR SELECT 
  USING (decorator_id = auth.uid());

CREATE POLICY "Decorators can manage own bookings" 
  ON bookings FOR UPDATE 
  USING (decorator_id = auth.uid());

-- Create Initial Admin Account
-- Email: admin@eventgallery.pro
-- Password: Admin@123456 (change this!)
-- Hash of bcrypt('Admin@123456') - $2a$10$...
INSERT INTO admins (email, password, first_name, last_name, role) 
VALUES (
  'admin@eventgallery.pro',
  '$2a$10$YIjlrHxwFhUV5pXgL8/KKeYZPMZZrC2zGQEEcBLEA5L7X9L5KlIiK',
  'Admin',
  'User',
  'super_admin'
) ON CONFLICT DO NOTHING;

-- Insert Default Subscription Plans
INSERT INTO subscription_plans (plan_name, plan_slug, monthly_price, yearly_price, gallery_limit, package_limit, features, description) VALUES
('Free', 'free', 0, 0, 50, 3, '["Basic gallery", "Up to 3 packages", "Basic analytics"]', 'Perfect for getting started'),
('Professional', 'professional', 299, 2990, 200, 10, '["Advanced gallery", "Up to 10 packages", "Advanced analytics", "Priority support", "Custom domain"]', 'For growing decorators'),
('Business', 'business', 599, 5990, 500, 25, '["Unlimited gallery", "Unlimited packages", "Advanced analytics", "24/7 support", "Custom domain", "API access"]', 'For established decorators'),
('Enterprise', 'enterprise', 1499, 14990, NULL, NULL, '["Everything in Business", "Dedicated account manager", "Custom integrations", "White label option"]', 'For agencies and teams');